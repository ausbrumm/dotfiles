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
      html            = { "htmlbeautifier", "prettierd", stop_after_first = true },
      css             = { "prettierd" },
      scss            = { "prettierd" },
      json            = { "prettierd" },
      yaml            = { "prettierd" },
      markdown        = { "prettierd" },
      graphql         = { "prettierd" },
      c               = { "clang-format", "prettierd", stop_after_first = true },
      cpp             = { "clang-format", "prettierd", stop_after_first = true },
      go              = { "goimports" },
      rust            = { "rustfmt" },
      python          = { "ruff" },
      csharp          = { "csharpier", "prettierd", stop_after_first = true },
      php             = { "pretty-php" },
      sh              = { "shfmt" },
      lua             = { "stylua" },
      sql             = { "sql-formmater" }
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
