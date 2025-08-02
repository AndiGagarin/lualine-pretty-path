local utils = require("lualine-pretty-path.utils")
---@class PrettyPath.ShellProvider: PrettyPath.Provider
---@field super PrettyPath.Provider
local M = require("lualine-pretty-path.providers.base"):extend()

function M.can_handle()
    return vim.bo.filetype == "shell"
end

---Renders the oil current directory as if it was the "filename" part.
---@return string
function M:render_dir()
    local name = vim.api.nvim_buf_get_name(0)
    name = vim.split(name, "//") [1]
    name  = name .. "//" .. vim.api.nvim_buf_get_var(0, "term_title")
    local hl = self.opts.highlights.filename

    return self.hl(name, hl)
end

function M:get_icon()
    return { "⚡", self.opts.highlights.filename }
end

function M:render()
    return table.concat({
        self:render_dir() or "",
        --self:render_symbols() or "",
    }, "")
end

return M
