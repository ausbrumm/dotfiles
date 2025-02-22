return {
  "folke/trouble.nvim",
  opts = { icons = true}, -- for default options, refer to the configuration section for custom setup.
  config = function()
    require("trouble").setup({
      icons = false,
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>t", function()
      require("trouble").toggle()
    end)

    vim.keymap.set("n", "<leader>tn", function()
      require("trouble").next({skip_groups = true, jump = true})
    end)

    vim.keymap.set("n", "<leader>tp", function()
      require("trouble").prev({skip_groups = true, jump = true})
    end)
  end
}
