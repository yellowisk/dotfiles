if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

if not set -q SSH_AUTH_SOCK
  eval (ss-agent -c)
end
ssh-add ~/.ssh/id_work 2>/dev/null

# Local secrets (API keys, etc.) — not tracked, lives outside this repo
if test -f ~/.secrets.fish
    source ~/.secrets.fish
end

# ===== Claude Native =====

function claude-native

    set -e ANTHROPIC_BASE_URL

    set -e ANTHROPIC_AUTH_TOKEN

    set -e ANTHROPIC_MODEL

    set -e ANTHROPIC_DEFAULT_OPUS_MODEL

    set -e ANTHROPIC_DEFAULT_SONNET_MODEL

    set -e ANTHROPIC_DEFAULT_HAIKU_MODEL

    set -e CLAUDE_CODE_SUBAGENT_MODEL

    set -e CLAUDE_CODE_EFFORT_LEVEL

end



# ===== Claude via DeepSeek =====

function claude-deepseek

    set -gx ANTHROPIC_BASE_URL "https://api.deepseek.com/anthropic"

    set -gx ANTHROPIC_AUTH_TOKEN $DEEPSEEK_API_KEY
    
    set -gx ANTHROPIC_MODEL "deepseek-v4-pro"
    
    set -gx ANTHROPIC_DEFAULT_OPUS_MODEL "deepseek-v4-pro"

end

# ==== Claude via Kimi ====

function claude-kimi

    set -gx ANTHROPIC_BASE_URL "https://api.moonshot.ai/anthropic"
    
    set -gx ANTHROPIC_AUTH_TOKEN $KIMI_API_KEY
    
    set -gx ANTHROPIC_MODEL "kimi-k2.7-code"

    set -gx ANTHROPIC_DEFALT_OPUS_MODEL "kimi-k3"

end

# ===== Claude Mode Check =====

function claude-mode
    if set -q ANTHROPIC_BASE_URL
        echo "deepseek ($ANTHROPIC_BASE_URL)"
    else
        echo "native (Anthropic)"
    end
end
