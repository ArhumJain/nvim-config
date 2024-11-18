-- Define a function to clean LaTeX auxiliary files
local function clean_aux_files()
    -- List of LaTeX auxiliary file extensions
    local extensions = {
        "aux", "log", "out", "toc", "bbl", "blg", "synctex.gz", 
        "fdb_latexmk", "fls", "nav", "snm", "vrb", "lot", "lof", "xdv"
    }
    -- Construct the command to find and delete auxiliary files
    local command = "find . "
    for _, ext in ipairs(extensions) do
        command = command .. "-name '*." .. ext .. "' -o "
    end
    command = command:sub(1, -5) .. " | xargs rm -f"  -- Remove the last " -o " and add xargs

    -- Run the command
    vim.fn.system(command)
    print("All auxiliary files have been cleaned.")
end

-- Register the clean_aux_files function as a custom command
vim.api.nvim_create_user_command("CleanTexAux", clean_aux_files, {})
