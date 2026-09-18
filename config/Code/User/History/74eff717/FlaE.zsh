# ~/.config/zsh/prompt.zsh

# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

FUNCNEST=100

eval "$(zoxide init zsh)"

# =========================================================
# Oh My Zsh
# =========================================================
export AGNOSTERZAK_CONFIG="$ZDOTDIR/agnosterzak.zsh-theme"

source "$ZDOTDIR/agnosterzak.zsh-theme"

# =========================================================
# Fastfetch
# =========================================================
# fastfetch. Will be disabled if above colorscript was chosen to install
fastfetch -c $HOME/.config/fastfetch/config.jsonc