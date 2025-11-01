require('avante').setup({
  provider = "azure",
  providers = {
    -- azure = {
    --   endpoint = "https://dev-sw-ao.openai.azure.com",
    --   deployment = "gpt-4.1",
    --   model = "gpt-4.1",
    --   api_version = "2024-12-01-preview",
    -- },
    azure = {
      endpoint = "https://dev-sw-ao.openai.azure.com",
      deployment = "gpt-5-nano",
      model = "gpt-5-nano",
      api_version = "2024-12-01-preview",
      extra_request_body = {
        temperature = 1,
        max_completion_tokens = 16384,
      },
    },
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-5",
    },
  },
  -- timeout = 30000,
  -- temperature = 1,
  -- max_tokens = 4096,
})
