-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local bufnr = event.buf
    local opts = { buffer = bufnr }

    -- Disable built-in omnifunc/completefunc to prevent double windows
    vim.bo[bufnr].omnifunc = ""
    vim.bo[bufnr].completefunc = ""

    -- Keymaps
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gc", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
  end,
})

-- This is copied straight from blink
-- https://cmp.saghen.dev/installation#merging-lsp-capabilities
local capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
}

require("mason").setup({})

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- Setup language servers.

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.mod", "go.work" },
})

vim.lsp.config("omnisharp", {
  cmd = { "omnisharp" },
  filetypes = { "cs", "sln", "csproj" },
  root_markers = { "*.sln", "*.csproj" },
})

vim.lsp.config("tsserver", {
  single_file_support = false,
  root_markers = { "tsconfig.json", "package.json", ".git" },
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false -- prevent lag from formatting
  end,
})


vim.lsp.config("angularls", {
  cmd = {
    "ngserver",
    "--stdio",
    "--tsProbeLocations", "/usr/local/lib/node_modules",
    "--ngProbeLocations", "/usr/local/lib/node_modules"
  },
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
  root_markers = { "angular.json", "project.json" },
  capabilities = capabilities,
})

vim.lsp.enable({
  "angularls",
  "luals",
  "clangd",
  "docker_compose",
  "dockerls",
  "gopls",
  "omnisharp",
  "rust_analyzer",
  "phpactor",
  "pylsp",
  "html",
  "graphql",
  "tsserver",
})
