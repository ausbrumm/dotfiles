vim.pack.add({ "https://github.com/stevearc/conform.nvim" }, { confirm = false })

require("conform").setup({
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
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
    sql             = { "sql_formatter" },
  },
  formatters = {
    prettierd = {
      command = "prettierd",
      env = {
        PRETTIERD_DEFAULT_CONFIG = "~/.config/prettier/.prettierrc.json",
      },
    },
  },
})
