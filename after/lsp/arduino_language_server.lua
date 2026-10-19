return {
  cmd = {
    "arduino-language-server",
    "-cli-config", vim.fn.expand("~/Library/Arduino15/arduino-cli.yaml"),
    "-cli", "arduino-cli",
    "-clangd", "clangd",
    "-fqbn", "arduino:avr:uno",
  },
}
