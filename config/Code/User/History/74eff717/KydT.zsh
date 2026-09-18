# ~/.config/zsh/prompt.zsh

# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

FUNCNEST=100

eval "$(zoxide init zsh)"

# =========================================================
# Oh My Zsh
# =========================================================


# =========================================================
# Fastfetch
# =========================================================
# fastfetch. Will be disabled if above colorscript was chosen to install
fastfetch -c $HOME/.config/fastfetch/config.jsonc