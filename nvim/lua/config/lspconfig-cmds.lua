-- Custom LSP Commands for native vim.lsp.config()

-- LspInfo - Show LSP client information
vim.api.nvim_create_user_command("LspInfo", function()
  local clients = vim.lsp.get_clients()
  local lines = {}

  -- Header
  table.insert(lines, "LSP Client Information")
  table.insert(lines, "======================")
  table.insert(lines, "")

  if #clients == 0 then
    table.insert(lines, "No active LSP clients")
  else
    table.insert(lines, "Active Clients (" .. #clients .. "):")
    table.insert(lines, "")

    for _, client in ipairs(clients) do
      table.insert(lines, "• " .. client.name .. " (id: " .. client.id .. ")")
      table.insert(lines, "  - Root directory: " .. (client.root_dir or "N/A"))
      table.insert(lines, "  - Filetypes: " .. table.concat(client.filetypes or {}, ", "))
      table.insert(lines, "  - Attached buffers: " .. #client.attached_buffers)

      if client.server_capabilities then
        local caps = {}
        if client.server_capabilities.completionProvider then table.insert(caps, "completion") end
        if client.server_capabilities.hoverProvider then table.insert(caps, "hover") end
        if client.server_capabilities.definitionProvider then table.insert(caps, "definition") end
        if client.server_capabilities.referencesProvider then table.insert(caps, "references") end
        if client.server_capabilities.documentFormattingProvider then table.insert(caps, "formatting") end

        if #caps > 0 then
          table.insert(lines, "  - Capabilities: " .. table.concat(caps, ", "))
        end
      end
      table.insert(lines, "")
    end
  end

  -- Current buffer info
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  table.insert(lines, "Current Buffer:")
  table.insert(lines, "- Filetype: " .. vim.bo.filetype)
  table.insert(lines, "- Attached clients: " .. #buf_clients)
  for _, client in ipairs(buf_clients) do
    table.insert(lines, "  • " .. client.name)
  end

  -- Display in a new buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'filetype', 'text')
  vim.api.nvim_win_set_buf(0, buf)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'readonly', true)
  vim.api.nvim_buf_set_name(buf, 'LSP Info')
end, { desc = "Show LSP client information" })

-- LspStart - Start LSP clients for current buffer
vim.api.nvim_create_user_command("LspStart", function(opts)
  local server_name = opts.args ~= "" and opts.args or nil

  if server_name then
    -- Start specific server
    local config = vim.lsp.get_config(server_name)
    if config then
      vim.lsp.start(config)
      print("Started LSP client: " .. server_name)
    else
      print("No configuration found for: " .. server_name)
    end
  else
    -- Start all applicable servers for current filetype
    local filetype = vim.bo.filetype
    local started = {}

    -- Get all configured servers
    local configs = vim.lsp.get_configs()
    for name, config in pairs(configs) do
      if config.filetypes and vim.tbl_contains(config.filetypes, filetype) then
        vim.lsp.start(config)
        table.insert(started, name)
      end
    end

    if #started > 0 then
      print("Started LSP clients: " .. table.concat(started, ", "))
    else
      print("No LSP clients configured for filetype: " .. filetype)
    end
  end
end, {
  nargs = "?",
  desc = "Start LSP client(s)",
  complete = function()
    local configs = vim.lsp.get_configs()
    return vim.tbl_keys(configs)
  end
})

-- LspStop - Stop LSP clients
vim.api.nvim_create_user_command("LspStop", function(opts)
  local server_name = opts.args ~= "" and opts.args or nil

  if server_name then
    -- Stop specific server
    local clients = vim.lsp.get_clients({ name = server_name })
    if #clients > 0 then
      for _, client in ipairs(clients) do
        vim.lsp.stop_client(client.id)
      end
      print("Stopped LSP client: " .. server_name)
    else
      print("No active client found for: " .. server_name)
    end
  else
    -- Stop all clients
    local clients = vim.lsp.get_clients()
    if #clients > 0 then
      local client_names = {}
      for _, client in ipairs(clients) do
        table.insert(client_names, client.name)
        vim.lsp.stop_client(client.id)
      end
      print("Stopped LSP clients: " .. table.concat(client_names, ", "))
    else
      print("No active LSP clients to stop")
    end
  end
end, {
  nargs = "?",
  desc = "Stop LSP client(s)",
  complete = function()
    local clients = vim.lsp.get_clients()
    local names = {}
    for _, client in ipairs(clients) do
      table.insert(names, client.name)
    end
    return names
  end
})

-- LspRestart - Restart LSP clients
vim.api.nvim_create_user_command("LspRestart", function(opts)
  local server_name = opts.args ~= "" and opts.args or nil

  if server_name then
    -- Restart specific server
    local clients = vim.lsp.get_clients({ name = server_name })
    local config = vim.lsp.get_config(server_name)

    if #clients > 0 and config then
      -- Stop the client
      for _, client in ipairs(clients) do
        vim.lsp.stop_client(client.id)
      end

      -- Wait a bit then restart
      vim.defer_fn(function()
        vim.lsp.start(config)
        print("Restarted LSP client: " .. server_name)
      end, 500)
    else
      print("No active client or configuration found for: " .. server_name)
    end
  else
    -- Restart all buffer clients
    local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
    if #buf_clients > 0 then
      local client_configs = {}
      local client_names = {}

      -- Collect configs before stopping
      for _, client in ipairs(buf_clients) do
        local config = vim.lsp.get_config(client.name)
        if config then
          client_configs[client.name] = config
          table.insert(client_names, client.name)
        end
        vim.lsp.stop_client(client.id)
      end

      -- Restart after delay
      vim.defer_fn(function()
        for name, config in pairs(client_configs) do
          vim.lsp.start(config)
        end
        print("Restarted LSP clients: " .. table.concat(client_names, ", "))
      end, 500)
    else
      print("No LSP clients active in current buffer")
    end
  end
end, {
  nargs = "?",
  desc = "Restart LSP client(s)",
  complete = function()
    local clients = vim.lsp.get_clients()
    local names = {}
    for _, client in ipairs(clients) do
      table.insert(names, client.name)
    end
    return names
  end
})

-- LspLog - Open LSP log file
vim.api.nvim_create_user_command("LspLog", function()
  local log_path = vim.lsp.get_log_path()
  vim.cmd("edit " .. log_path)
end, { desc = "Open LSP log file" })
