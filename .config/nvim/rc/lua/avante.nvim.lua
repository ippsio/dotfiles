require("avante").setup({
  provider = "claude",
  providers = {
    claude = {
      model = "claude-sonnet-4-20250514",
      extra_request_body = {
        max_tokens = 4096,
      },
    },
  },
  behaviour = {
    auto_suggestions = false,
  },
  windows = {
    width = 40,
  },
})
