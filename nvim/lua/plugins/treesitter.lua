-- NOTE: Run :TSUpdate after first install; :TSInstall <lang> to add parsers
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })

-- Angular filetype detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.component.html", "*.container.html" },
  callback = function(args)
    vim.bo[args.buf].filetype = "htmlangular"
  end,
})

vim.filetype.add({ extension = { templ = "templ" } })
vim.treesitter.language.register("templ", "templ")

-- Install parsers on startup if not already present
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local install = require("nvim-treesitter.install")
    local config = require("nvim-treesitter.config")
    local want = {
      "vimdoc", "javascript", "typescript", "tsx",
      "json", "html", "css", "scss", "lua", "python",
      "rust", "go", "bash", "cpp", "c", "toml",
      "dockerfile", "graphql", "haskell", "latex", "swift",
    }
    local installed = vim.list_contains and {} or {}
    for _, v in ipairs(config.get_installed()) do
      installed[v] = true
    end
    local missing = vim.tbl_filter(function(l) return not installed[l] end, want)
    if #missing > 0 then
      install.install(missing)
    end
  end,
})
