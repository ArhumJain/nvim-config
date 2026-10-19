local aux_extensions = {
  "aux", "log", "out", "toc", "bbl", "blg", "synctex.gz",
  "fdb_latexmk", "fls", "nav", "snm", "vrb", "lot", "lof", "xdv",
}

local function is_aux_file(name)
  for _, ext in ipairs(aux_extensions) do
    if name:sub(-#ext - 1) == "." .. ext then
      return true
    end
  end
  return false
end

local function clean_tex_aux()
  local files = vim.fs.find(is_aux_file, { limit = math.huge, type = "file" })
  local removed = 0
  for _, file in ipairs(files) do
    if vim.uv.fs_unlink(file) then
      removed = removed + 1
    end
  end
  vim.notify(string.format("CleanTexAux: removed %d file%s", removed, removed == 1 and "" or "s"))
end

vim.api.nvim_create_user_command("CleanTexAux", clean_tex_aux, {})
