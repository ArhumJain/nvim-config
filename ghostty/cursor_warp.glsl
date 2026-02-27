// cursor_warp.glsl — Hybrid cursor animation for Ghostty
//
// Small moves (≤ SMALL_MOVE_CELLS × line-height in total distance):
//   → Smooth slide: cursor glides cleanly from A to B.
//     For horizontal moves the real cursor at the destination is hidden so
//     only the animated one is visible, giving a true slide with no ghost.
//
// Large moves (jumps, clicks, page-up/down, etc.):
//   → Warp smear: cursor stretches between old and new positions.

// ─── SHARED ──────────────────────────────────────────────────────────────────

// Distance threshold, expressed as a multiple of the LINE HEIGHT (not cursor
// width — that breaks for bar/beam cursors).  1.2 × line-height comfortably
// covers any 1-character or 1-line move regardless of font metrics.
const float SMALL_MOVE_CELLS = 1.2;

const float BLUR = 1.0; // edge antialiasing in pixels

// ─── SLIDE (small move) ───────────────────────────────────────────────────────

const float SLIDE_DURATION = 0.05; //

// ─── WARP (large move) ───────────────────────────────────────────────────────

// TRAIL_COLOR: set to iCurrentCursorColor or e.g. vec4(0.2, 0.6, 1.0, 0.5)
// (configured inside the warp block below to avoid a global register allocation)
const float WARP_DURATION        = 0.1;
const float TRAIL_SIZE           = 0.8;
const float WARP_MIN_DIST        = 1.5;  // min distance (× line height) to draw trail
const float TRAIL_THICKNESS      = 1.0;
const float TRAIL_THICKNESS_X    = 0.9;

const float FADE_ENABLED  = 0.0;
const float FADE_EXPONENT = 5.0;

// ─── EASING ──────────────────────────────────────────────────────────────────

const float PI = 3.14159265359;
const float C1_BACK = 1.70158;
const float C3_BACK = C1_BACK + 1.0;
const float C4_ELASTIC = (2.0 * PI) / 3.0;
const float SPRING_STIFFNESS = 9.0;
const float SPRING_DAMPING   = 0.9;

// // Linear
// float ease(float x) { return x; }
// // EaseOutQuad
// float ease(float x) { return 1.0 - (1.0 - x) * (1.0 - x); }
// // EaseOutCubic
// float ease(float x) { return 1.0 - pow(1.0 - x, 3.0); }
// // EaseOutQuart
// float ease(float x) { return 1.0 - pow(1.0 - x, 4.0); }
// // EaseOutSine
// float ease(float x) { return sin((x * PI) / 2.0); }
// // EaseOutExpo
// float ease(float x) { return x == 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * x); }

// EaseOutCirc (default)
float ease(float x) { return sqrt(1.0 - pow(x - 1.0, 2.0)); }

// // EaseOutBack
// float ease(float x) {
//     return 1.0 + C3_BACK * pow(x - 1.0, 3.0) + C1_BACK * pow(x - 1.0, 2.0);
// }
// // EaseOutElastic
// float ease(float x) {
//     return x == 0.0 ? 0.0
//          : x == 1.0 ? 1.0
//                     : pow(2.0, -10.0 * x) * sin((x * 10.0 - 0.75) * C4_ELASTIC) + 1.0;
// }

// ─── UTILITIES ───────────────────────────────────────────────────────────────

// Pixel coords → normalised space (screen height = 2).
// isPos: 1.0 for positions, 0.0 for sizes/deltas.
vec2 toNorm(vec2 v, float isPos) {
    return (v * 2.0 - iResolution.xy * isPos) / iResolution.y;
}

// Normalised coords → texture UV.
vec2 normToUV(vec2 n) {
    return (n * iResolution.y + iResolution.xy) / (2.0 * iResolution.xy);
}

float sdfRect(vec2 p, vec2 center, vec2 halfSize) {
    vec2 d = abs(p - center) - halfSize;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

float seg(in vec2 p, in vec2 a, in vec2 b, inout float s, float d) {
    vec2  e = b - a, w = p - a;
    float t = clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    vec2  r = w - e * t;          // == p - (a + e*t), without the redundant a+ step
    d = min(d, dot(r, r));
    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float allC  = c0 * c1 * c2;
    float noneC = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    s *= mix(1.0, -1.0, step(0.5, allC + noneC));
    return d;
}

float sdfConvexQuad(vec2 p, vec2 v1, vec2 v2, vec2 v3, vec2 v4) {
    float s = 1.0, d = dot(p - v1, p - v1);
    d = seg(p, v1, v2, s, d); d = seg(p, v2, v3, s, d);
    d = seg(p, v3, v4, s, d); d = seg(p, v4, v1, s, d);
    return s * sqrt(d);
}

float antialias(float dist, float blurPx) {
    return 1.0 - smoothstep(0.0, blurPx * 2.0 / iResolution.y, dist);
}

float getDurationFromDot(float dv, float lead, float side, float trail) {
    float isLead = step(0.5, dv);
    float isSide = step(-0.5, dv) * (1.0 - isLead);
    return mix(mix(trail, side, isSide), lead, isLead);
}

// ─── MAIN ────────────────────────────────────────────────────────────────────

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    // ── Fast pre-checks — avoid all heavy math when no animation is active ────
    float elapsed    = iTime - iTimeCursorChange;
    float lineHeight = iCurrentCursor.w;  // line height: reliable for all cursor styles
    vec2  pixelDelta = abs(iCurrentCursor.xy - iPreviousCursor.xy);
    float moveDist2  = dot(pixelDelta, pixelDelta);        // squared — no sqrt needed
    float slideThresh = lineHeight * SMALL_MOVE_CELLS;
    bool  smallMove  = (moveDist2 < slideThresh * slideThresh);

    if (smallMove  && elapsed >= SLIDE_DURATION) return;
    if (!smallMove && elapsed >= WARP_DURATION)  return;

    // ── Normalised cursor geometry — only reached when animation is active ────
    const vec2 offsetFactor = vec2(-0.5, 0.5);

    vec4 cc = vec4(toNorm(iCurrentCursor.xy,  1.0), toNorm(iCurrentCursor.zw,  0.0));
    vec4 cp = vec4(toNorm(iPreviousCursor.xy, 1.0), toNorm(iPreviousCursor.zw, 0.0));

    vec2 destCenter = cc.xy - cc.zw * offsetFactor;
    vec2 srcCenter  = cp.xy - cp.zw * offsetFactor;
    vec2 halfSize   = cc.zw * 0.5;

    vec2 vu = toNorm(fragCoord, 1.0);

    // ── SLIDE — smooth caret for small moves ─────────────────────────────────
    if (smallMove) {
        if (moveDist2 < 1.0) return; // sub-pixel jitter — nothing visible to animate

        float t = ease(clamp(elapsed / SLIDE_DURATION, 0.0, 1.0));

        // Is the move primarily horizontal?  (dominant x, negligible y)
        bool isHorizontal = (pixelDelta.x > pixelDelta.y)
                         && (pixelDelta.y < lineHeight * 0.5);

        if (isHorizontal) {
            // ── Erase the real cursor at the destination ──────────────────
            // Sample background from one cursor-width beyond the destination
            // in the direction of travel.  For rightward typing this cell is
            // empty; for leftward navigation it may be text, but the artifact
            // is short-lived (< SLIDE_DURATION).
            vec2 moveDir  = sign(destCenter - srcCenter);
            vec2 bgSample = destCenter + cc.zw * moveDir * 1.5;
            vec4 bgColor  = texture(iChannel0, clamp(normToUV(bgSample), 0.001, 0.999));

            // Inside-rect test only: max(d.x, d.y) <= 0 avoids sqrt.
            vec2 ed = abs(vu - destCenter) - halfSize;
            if (max(ed.x, ed.y) <= 0.0) fragColor = bgColor;
        }
        // For vertical (up/down) the two cursors are on separate lines, which
        // is visually acceptable — no erase step needed.

        // Draw the animated cursor at the interpolated position
        vec2  animCenter = mix(srcCenter, destCenter, t);
        float d          = sdfRect(vu, animCenter, halfSize);
        float a          = antialias(d, BLUR);
        if (a > 0.0) {
            vec4 col = iCurrentCursorColor;
            fragColor = mix(fragColor, vec4(col.rgb, fragColor.a), a * col.a);
        }
        return;
    }

    // ── WARP — smear trail for large moves ───────────────────────────────────
    // elapsed < WARP_DURATION already guaranteed by early exit above.
    // Hoist moveVec so it serves both the guard and the body (no duplicate subtraction).
    vec2  moveVec     = destCenter - srcCenter;
    float lineLength2 = dot(moveVec, moveVec);  // squared — avoids sqrt in guard
    float minDist     = cc.w * WARP_MIN_DIST;
    vec4  newColor    = vec4(fragColor);

    if (lineLength2 > minDist * minDist) {

        const float DLEAD  = WARP_DURATION * (1.0 - TRAIL_SIZE);
        const float DTRAIL = WARP_DURATION;
        const float DSIDE  = (DLEAD + DTRAIL) * 0.5;

        vec2 s = sign(moveVec);

        // Scalar cursor geometry — shared by all shape branches.
        float cc_hy = cc.w * 0.5 * TRAIL_THICKNESS,  cc_hx = cc.z * 0.5 * TRAIL_THICKNESS_X;
        float cc_cy = cc.y - cc.w * 0.5,              cc_cx = cc.x + cc.z * 0.5;
        float cp_hy = cp.w * 0.5 * TRAIL_THICKNESS,  cp_hx = cp.z * 0.5 * TRAIL_THICKNESS_X;
        float cp_cy = cp.y - cp.w * 0.5,              cp_cx = cp.x + cp.z * 0.5;

        // dot(vec2(±1,±1), s) == ±s.x ± s.y — scalar arithmetic.
        float dur_tl = getDurationFromDot(-s.x + s.y, DLEAD, DSIDE, DTRAIL);
        float dur_tr = getDurationFromDot( s.x + s.y, DLEAD, DSIDE, DTRAIL);
        float dur_bl = getDurationFromDot(-s.x - s.y, DLEAD, DSIDE, DTRAIL);
        float dur_br = getDurationFromDot( s.x - s.y, DLEAD, DSIDE, DTRAIL);

        // Rail averages: ((sx+sy)+(sx-sy))/2 = sx, ((-sx+sy)+(-sx-sy))/2 = -sx.
        float iR = step(0.5, s.x), iL = step(0.5, -s.x);
        float durRail_r = getDurationFromDot( s.x, DLEAD, DSIDE, DTRAIL);
        float durRail_l = getDurationFromDot(-s.x, DLEAD, DSIDE, DTRAIL);

        // s depends only on uniforms → all threads take the same branch (no divergence).
        float shapeAlpha;
        if (s.y == 0.0) {
            // ── Pure horizontal ───────────────────────────────────────────────
            // The quad degenerates to a rect: left corners share one progress,
            // right corners share another.  sdfRect is ~10× cheaper than
            // sdfConvexQuad.  eBlur==0 here so antialias degenerates to a step
            // — skip the sqrt entirely and use an inside-rect test.
            float prog_l = ease(clamp(elapsed / mix(dur_tl, durRail_l, iL), 0.0, 1.0));
            float prog_r = ease(clamp(elapsed / mix(dur_tr, durRail_r, iR), 0.0, 1.0));
            float lx = mix(cp_cx - cp_hx, cc_cx - cc_hx, prog_l);
            float rx = mix(cp_cx + cp_hx, cc_cx + cc_hx, prog_r);
            vec2  ad = abs(vu - vec2((lx + rx) * 0.5, cc_cy)) - vec2((rx - lx) * 0.5, cc_hy);
            shapeAlpha = step(max(ad.x, ad.y), 0.0);

        } else if (s.x == 0.0) {
            // ── Pure vertical ─────────────────────────────────────────────────
            // Same simplification.  iL == iR == 0 when s.x == 0 (no rail override).
            float prog_t = ease(clamp(elapsed / dur_tl, 0.0, 1.0)); // dur_tl == dur_tr
            float prog_b = ease(clamp(elapsed / dur_bl, 0.0, 1.0)); // dur_bl == dur_br
            float ty = mix(cp_cy + cp_hy, cc_cy + cc_hy, prog_t);
            float by = mix(cp_cy - cp_hy, cc_cy - cc_hy, prog_b);
            vec2  ad = abs(vu - vec2(cc_cx, (ty + by) * 0.5)) - vec2(cc_hx, (ty - by) * 0.5);
            shapeAlpha = step(max(ad.x, ad.y), 0.0);

        } else {
            // ── Diagonal ──────────────────────────────────────────────────────
            // Full convex quad + antialiased edge (eBlur == BLUR for diagonal).
            float prog_tl = ease(clamp(elapsed / mix(dur_tl, durRail_l, iL), 0.0, 1.0));
            float prog_tr = ease(clamp(elapsed / mix(dur_tr, durRail_r, iR), 0.0, 1.0));
            float prog_bl = ease(clamp(elapsed / mix(dur_bl, durRail_l, iL), 0.0, 1.0));
            float prog_br = ease(clamp(elapsed / mix(dur_br, durRail_r, iR), 0.0, 1.0));
            float sdfTrail = sdfConvexQuad(vu,
                mix(vec2(cp_cx-cp_hx, cp_cy+cp_hy), vec2(cc_cx-cc_hx, cc_cy+cc_hy), prog_tl),
                mix(vec2(cp_cx+cp_hx, cp_cy+cp_hy), vec2(cc_cx+cc_hx, cc_cy+cc_hy), prog_tr),
                mix(vec2(cp_cx+cp_hx, cp_cy-cp_hy), vec2(cc_cx+cc_hx, cc_cy-cc_hy), prog_br),
                mix(vec2(cp_cx-cp_hx, cp_cy-cp_hy), vec2(cc_cx-cc_hx, cc_cy-cc_hy), prog_bl));
            shapeAlpha = antialias(sdfTrail, BLUR); // abs(s.x)*abs(s.y)==1 for diagonal
        }

        vec4 trail = iCurrentCursorColor; // change to e.g. vec4(0.2, 0.6, 1.0, 0.5)
        if (FADE_ENABLED > 0.5) {
            float fadeProg = clamp(dot(vu - srcCenter, moveVec) / (lineLength2 + 1e-6), 0.0, 1.0);
            trail.a *= pow(fadeProg, FADE_EXPONENT);
        }

        newColor = mix(newColor, vec4(trail.rgb, newColor.a), trail.a * shapeAlpha);

        // Punch-hole: restore real cursor on top of trail (inside-rect, no sqrt).
        vec2 pd = abs(vu - destCenter) - halfSize;
        newColor = mix(newColor, fragColor, step(max(pd.x, pd.y), 0.0));
    }

    fragColor = newColor;
}
