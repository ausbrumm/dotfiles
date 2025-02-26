return {
		"nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
      },
    name = "telescope",
    config = function()
      require('telescope').setup({})
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = "Find Files"})
      vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = "Git Files"})

      vim.keymap.set('n', '<leader>pws',
        function()
        local word = vim.fn.expand("<cword>")
          builtin.grep_string({search = word})
        end,
        {desc = "Search Word"}
      )
    vim.keymap.set('n', '<leader>pWs',
      function()
        local word = vim.fn.expand("<cWORD>")
        builtin.grep_string({search = word})
      end,
      {desc = "Grep String"}
    )

      vim.keymap.set('n', '<leader>ps',
        function()
          builtin.grep_string({search = vim.fn.input("Grep > ")})
        end,
        {desc = "Grep String"}
      )
      vim.keymap.set('n', '<leader>vh', builtin.help_tags, {desc = "Help Tags"})
    end,
}
