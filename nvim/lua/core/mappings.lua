
vim.g.mapleader = " " -- leader key

local keymap = vim.keymap

keymap.set("n", "<leader>pv", vim.cmd.Ex, {desc = "Open Explore"}) -- need nvim 0



-- press jk in insert mode to escape
keymap.set("i", "jk", "<ESC>", {desc = "Exit Insert mode with jk"})

-- press n to remove highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", {desc="Clear search highlights"})

-- deletes selected text, pastes yank'd copy, throw in the black hole
-- src: ThePrimeagen
vim.keymap.set("x", "<leader>p", [["_dP]], {desc ="paste and send to void"})

-- copy to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], {desc="Yank to clipboard"})
vim.keymap.set("n", "<leader>Y", [["+Y]], {desc = "Yank line to clipboard"})

-- this is the yankable
keymap.set("n", "<leader>+","<C-a>", {desc = "Increment Number"})
keymap.set("n", "<leader>-","<C-x>", {desc = "Decrement Number"})

vim.keymap.set("i", "<C-c>", "<Esc>")

-- window management
keymap.set("n", "<leader>wv", "<C-w>v", {desc="Split window vertically"})
keymap.set("n", "<leader>wh", "<C-w>s", {desc="Split window horizontally"})
keymap.set("n", "<leader>we", "<C-w>=", {desc="Make splits equal size"})
keymap.set("n", "<leader>wx", "<cmd>close<CR>", {desc="Close current split"})

-- global search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
          {desc = "Global Search and Replace"})

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
   vim.cmd("so")
 end, {desc = "Source Current File"})

 -- fzf
 vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", {desc = "buffers"})
 vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", {desc = "files"})
 vim.keymap.set("n", "<leader>f", "<cmd>FzfLua<CR>", {desc = "fzf"})

 vim.keymap.set("n", "π", "<cmd>PrettierAsync<CR>", {desc = "Prettier"})
