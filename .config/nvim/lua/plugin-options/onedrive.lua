require("onedrive").setup({
  client_id = vim.env["MICROSOFT_ONEDRIVE_CLIENT_ID"],
  tenant    = "consumers",  -- gebruik dit voor je persoonlijke Microsoft-account
  -- Optionele parameters:
  -- scope      = "openid profile offline_access Files.ReadWrite",
  -- link_type  = "view",
  -- link_scope = "anonymous",
})
