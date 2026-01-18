require("CopilotChat").setup({
  debug = false,
  window = {
    layout = 'vertical',
  },
  system_prompt = [[
    You are an experienced Japanese senior programmer.
    Please follow the rules below when responding:
    1. Provide all explanations in Japanese.
    2. Write all comments in the code in Japanese.
    3. Include English technical terms as needed.
    4. Ensure the code is practical and of production-ready quality.
    5. Apply best practices and design patterns.
  ]],
  question_header = '## User ',
  answer_header = '## Copilot ',
  error_header = '## Error ',
  mappings = {
    complete = false, -- Tab補完を無効化
  }
})
-- バッファ全体を対象に日本語で質問
function CopilotChatAsk(prompt_prefix, prompt_suffix)
    local prompt = prompt_prefix .. (prompt_suffix or "")
    require("CopilotChat").ask(prompt, { 
        selection = require("CopilotChat.select").buffer,
    })
end

-- 複数バッファを対象に質問
function CopilotChatAskMultiple(prompt)
    local full_prompt = prompt .. "\n\n#buffers"
    require("CopilotChat").ask(full_prompt, { 
        selection = require("CopilotChat.select").buffers,
    })
end

-- カスタム入力を受け付ける関数
function CopilotChatWithInput(prompt_text, use_multiple_buffers)
    local input = vim.fn.input(prompt_text .. ": ")
    if input ~= "" then
        if use_multiple_buffers then
            CopilotChatAskMultiple(input)
        else
            CopilotChatAsk(input)
        end
    end
end
