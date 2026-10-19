return {
  -- A partial capabilities table merges onto the defaults (including
  -- blink.cmp's) instead of replacing them.
  capabilities = {
    textDocument = {
      publishDiagnostics = {
        tagSupport = { valueSet = { 2 } },
      },
    },
  },
  settings = {
    pyright = {
      disableOrganizeImports = true, -- Using Ruff
    },
    python = {
      analysis = {
        ignore = { "*" }, -- Using Ruff
        typeCheckingMode = "off", -- Using mypy
      },
    },
  },
}
