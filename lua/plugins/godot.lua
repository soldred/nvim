-- Godot (GDScript) support. The pieces live in different files:
--   lsp.lua         enables the GDScript language server (hosted by the running Godot editor)
--   treesitter.lua  installs the gdscript, godot_resource and gdshader parsers
--   this file       lets Godot open scripts in this Neovim, and formats GDScript with gdformat

local M = {}

-- Godot talks to Neovim through this socket (see the Godot section of the README).
local socket = vim.fn.stdpath("cache") .. "/godot.sock"

-- A window that holds a regular file (not neo-tree, a floating window, a help buffer, ...)
local function is_file_window(win)
    return vim.api.nvim_win_get_config(win).relative == "" and vim.bo[vim.api.nvim_win_get_buf(win)].buftype == ""
end

-- Called by Godot (via `nvim --server ... --remote-send`) to open a script.
-- Godot sends line 1, col 1 when it has no position to give, so that case leaves the cursor alone.
function M.open(file, line, col)
    if not is_file_window(vim.api.nvim_get_current_win()) then
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if is_file_window(win) then
                vim.api.nvim_set_current_win(win)
                break
            end
        end
    end

    vim.cmd.drop(vim.fn.fnameescape(file))

    if line > 1 or col > 1 then
        pcall(vim.api.nvim_win_set_cursor, 0, { line, math.max(col - 1, 0) })
    end
end

-- Serve the socket when Neovim is started inside a Godot project.
local function start_server()
    vim.fn.mkdir(vim.fs.dirname(socket), "p")

    if vim.uv.fs_stat(socket) then
        local ok, chan = pcall(vim.fn.sockconnect, "pipe", socket, { rpc = true })
        if ok and chan > 0 then
            -- another Neovim already owns the socket
            vim.fn.chanclose(chan)
            return
        end
        -- nobody answers: stale socket left behind by a crashed session
        vim.uv.fs_unlink(socket)
    end

    pcall(vim.fn.serverstart, socket)
end

if vim.fs.find("project.godot", { upward = true, path = vim.fn.getcwd() })[1] then
    start_server()
end

-- Godot's language server cannot format, so use gdformat from gdtoolkit (:MasonInstall gdtoolkit)
local function format_gdscript()
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    local ok, res = pcall(function()
        return vim.system({ "gdformat", "-" }, { stdin = table.concat(lines, "\n") .. "\n", text = true }):wait()
    end)
    if not ok then
        vim.notify("gdformat not found, install it with :MasonInstall gdtoolkit", vim.log.levels.ERROR)
        return
    end
    if res.code ~= 0 then
        local msg = res.stderr ~= "" and res.stderr or res.stdout
        vim.notify("gdformat failed:\n" .. vim.trim(msg), vim.log.levels.ERROR)
        return
    end

    local formatted = vim.split(res.stdout, "\n", { plain = true })
    if formatted[#formatted] == "" then
        table.remove(formatted)
    end
    if vim.deep_equal(formatted, lines) then
        return
    end

    local view = vim.fn.winsaveview()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, formatted)
    vim.fn.winrestview(view)
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "gdscript",
    desc = "Format GDScript with gdformat",
    callback = function(args)
        vim.keymap.set("n", "<leader>f", format_gdscript, { buffer = args.buf, desc = "Format buffer (gdformat)" })
    end,
})

return M
