return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
     require('nvim-treesitter.configs').setup ({
      -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      ensure_installed = { "vimdoc", "javascript", "typescript", "tsx", 
                          "json", "html", "css", "scss", "lua", "python",
                          "jsonc", "rust", "go", "bash", "cpp", "c", "toml", 
                          "dockerfile", "graphql", "haskell", "latex", "swift" },
      -- install parsers sybcronously (only applied to 'ensure_installed')
      sync_install = false,
      auto_install = true,
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' },
      },
     })

     local treesitter_parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
     treesitter_parser_configs.templ = {
        install_info = {
          url = "https://github.com/vrischmann/tree-sitter-templ.git",
          files = {"src/parser.c", "src/scanner.c"},
          branch = "master"
        },
     }

     vim.treesitter.language.register('templ', 'templ')
  end,
}
