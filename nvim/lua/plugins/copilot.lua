return {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  config = function() require("copilot_cmp") end,
  dependencies = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
}
