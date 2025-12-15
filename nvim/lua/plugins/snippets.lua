return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    dependencies = { "rafamadriz/friendly-snippets" },

    config = function()
      local ls = require("luasnip")
      ls.filetype_extend("javascript", { "jsdoc" })
      ls.filetype_extend("typescript", { "tsdoc" })
      ls.filetype_extend("typescript", { "javascript" })
      ls.filetype_extend("rust", { "rustdoc" })
      ls.filetype_extend("python", { "pydoc" })
      ls.filetype_extend("c", { "cdoc" })
      ls.filetype_extend("sh", { "shelldoc" })
      ls.filetype_extend("html", { "htmldoc" })
      ls.filetype_extend("go", { "godoc" });
      --- TODO: What is expand?
      vim.keymap.set({ "i" }, "<C-s>e", function() ls.expand() end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-s>;", function() ls.jump(1) end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-s>,", function() ls.jump(-1) end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  }
}
