require('avante').setup({
  provider = "azure",
  providers = {
    azure = {
      endpoint = "https://dev-sw-ao.openai.azure.com",
      deployment = "gpt-4.1",
      model = "gpt-4.1",
      api_version = "2025-01-01-preview",
    },
  },
  timeout = 30000,
  temperature = 0,
  max_tokens = 4096,
})
