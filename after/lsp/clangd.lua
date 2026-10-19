return {
  -- ArduPilot cross-compiles with arm-none-eabi-g++. clangd will not run an
  -- unknown driver to learn its system include paths unless the driver is
  -- whitelisted, and without those paths every standard header fails to
  -- resolve. This flag is command-line only; it cannot be set in .clangd.
  cmd = {
    "clangd",
    "--query-driver=/**/arm-none-eabi-*",
  },
}
