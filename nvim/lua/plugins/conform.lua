local global_node_modules = vim.fn.trim(vim.fn.system("npm root -g"))
local prettierd_path = vim.fn.trim(vim.fn.system("which prettierd"))

return {
  "stevearc/conform.nvim",
  --  event = { "BufReadPre", "BufNewFile" },
  lazy = false,
  opts = {
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      javascript      = { "prettierd" },
      typescript      = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      html            = { "prettierd" },
      css             = { "prettierd" },
      scss            = { "prettierd" },
      json            = { "prettierd" },
      yaml            = { "prettierd" },
      markdown        = { "prettierd" },
      graphql         = { "prettierd" },
      c               = { "clang-format" },
      cpp             = { "clang-format" },
      go              = { "goimports" },
      rust            = { "rustfmt" },
      python          = { "ruff" }
    },
    formatters = {
      prettierd = {
        command = prettierd_path,
        env = {
          PRETTIERD_DEFAULT_CONFIG = "~/.config/prettier/.prettierrc.json",
          NODE_PATH = global_node_modules,
        },
      },
    },
  },
}
