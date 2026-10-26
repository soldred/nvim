-- Names of installed plugins, filtered by what's already typed (for tab-completion)
local function pack_names(arglead)
    local names = vim.tbl_map(function(p)
        return p.spec.name
    end, vim.pack.get())

    return vim.tbl_filter(function(name)
        return vim.startswith(name, arglead)
    end, names)
end

-- Pack Delete and Update cmds are built-in on Nightly 0.13
vim.api.nvim_create_user_command("PackDel", function(opts)
    vim.pack.del(opts.fargs)
end, { nargs = "+", complete = pack_names, desc = "Delete plugins (:PackDel plugin1 plugin2)" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
    -- no arguments -> update everything
    vim.pack.update(#opts.fargs > 0 and opts.fargs or nil)
end, { nargs = "*", complete = pack_names, desc = "Update all plugins or specific ones" })
