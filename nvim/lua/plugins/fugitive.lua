return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, {desc = "Git"})

    vim.keymap.set("n", "<leader>gi", function()
      vim.cmd.Git('init')
    end, {desc = "init"})

    vim.keymap.set("n", "<leader>gc", function()
      vim.cmd.Git('commit')
    end, {desc = "commit"})

    local ausbrumm_fugitive = vim.api.nvim_create_augroup("ausbrumm_fugitive", {})
    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
      group = ausbrumm_fugitive,
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {buffer = bufnr, remap = false}
        vim.keymap.set("n", "<leader>p", function()
          vim.cmd.Git('push')
        end, { desc = "push" })

        -- rebase always
        vim.keymap.set("n", "<leader>P",
          function()
            vim.cmd.Git({'pull', '--rebase'})
          end,
        opts)

        vim.keymap.set("n", "<leader>gpo", ":Git push -u origin ", {desc = "push to origin"})
      end,
    })
    vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
    vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
  end
}
