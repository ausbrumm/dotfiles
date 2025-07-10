return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter.configs').setup({
      -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      ensure_installed = { "vimdoc", "javascript", "typescript", "tsx",
        "json", "html", "css", "scss", "lua", "python",
        "jsonc", "rust", "go", "bash", "cpp", "c", "toml",
        "dockerfile", "graphql", "haskell", "latex", "swift", "angular" },
      ignore_installed = { "org" },
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

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { "*.component.html", "*.container.html" },
      callback = function(args)
        vim.bo[args.buf].filetype = "angular"
      end,
    })

    local treesitter_parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
    treesitter_parser_configs.templ = {
      install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master"
      },
    }


    treesitter_parser_configs.angular = {
      install_info = {
        url = "https://github.com/ikatyang/tree-sitter-angular",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "angular", -- optionally map it over .html files
    }

    vim.treesitter.language.register('templ', 'templ')
  end,
}
