# -----------------------------------------------------
#           Gaming Evolution Centre Theme
# -----------------------------------------------------

# GamingEvolutionCentre Theme is a custom Powerline-inspired Oh My Zsh theme built for Arch Linux and development workflows.
# It features configurable hex colours, Git integration, date and time, system information, and automatic indicators for popular programming languages and development tools.

# =====================================================
#                    THEME SETTINGS
# =====================================================

# Show numeric return code instead of ✘
: "${AGNOSTER_STATUS_RETVAL_NUMERIC:=false}"

# Git directory inline
: "${AGNOSTER_GIT_INLINE:=true}"

# Show Git ahead / behind
: "${AGNOSTER_GIT_BRANCH_STATUS:=true}"

# Show Linux segment
: "${GEC_SHOW_LINUX:=true}"

# Show Neovim whenever nvim is installed.
# Change to false if you only want it inside Neovim.
: "${GEC_SHOW_NEOVIM_ALWAYS:=true}"

# Show application versions
: "${GEC_SHOW_VERSIONS:=true}"


# =====================================================
#                      CHARACTERS
# =====================================================

# Powerline arrow
#
# 
#
SEGMENT_SEPARATOR=$'\ue0b0'

PLUSMINUS=$'\u00b1'
BRANCH=$'\ue0a0'
DETACHED=$'\u27a6'
CROSS=$'\u2718'
LIGHTNING=$'\u26a1'
GEAR=$'\u2699'


# -----------------------------------------------------
# Nerd Font Icons
# -----------------------------------------------------

# GitHub
GITHUB_CHAR=$'\uf408'

# Arch Linux
LINUX_CHAR=$'\uf303'

# Neovim
NEOVIM_CHAR=$'\ue6ae'

# Python
PYTHON_CHAR=$'\ue73c'

# Node.js
NODE_CHAR=$'\ue718'

# Java
JAVA_CHAR=$'\ue738'

# JavaScript
JAVASCRIPT_CHAR=$'\ue74e'

# .NET
DOTNET_CHAR=$'\ue77f'

# npm
NPM_CHAR=$'\ue71e'


CURRENT_BG='NONE'


# =====================================================
#                    CUSTOM COLOURS
# =====================================================
#
# All colours use HEX:
#
#   #RRGGBB
#
# Change anything in this section to customise the
# entire prompt.
#
# =====================================================


# -----------------------------------------------------
# Linux
# -----------------------------------------------------

: "${GEC_LINUX_FG:=#FFFFFF}"
: "${GEC_LINUX_BG:=#1793D1}"


# -----------------------------------------------------
# Date + Time
# -----------------------------------------------------

: "${GEC_DATETIME_FG:=#FFFFFF}"
: "${GEC_DATETIME_BG:=#7C3AED}"


# -----------------------------------------------------
# Current Directory
# -----------------------------------------------------

: "${AGNOSTER_DIR_FG:=#FFFFFF}"
: "${AGNOSTER_DIR_BG:=#2563EB}"


# -----------------------------------------------------
# Git
# -----------------------------------------------------

# Clean
: "${AGNOSTER_GIT_CLEAN_FG:=#0B0F14}"
: "${AGNOSTER_GIT_CLEAN_BG:=#22C55E}"

# Dirty
: "${AGNOSTER_GIT_DIRTY_FG:=#0B0F14}"
: "${AGNOSTER_GIT_DIRTY_BG:=#F59E0B}"


# -----------------------------------------------------
# Mercurial
# -----------------------------------------------------

: "${AGNOSTER_HG_NEWFILE_FG:=#FFFFFF}"
: "${AGNOSTER_HG_NEWFILE_BG:=#EF4444}"

: "${AGNOSTER_HG_CHANGED_FG:=#0B0F14}"
: "${AGNOSTER_HG_CHANGED_BG:=#F59E0B}"

: "${AGNOSTER_HG_CLEAN_FG:=#0B0F14}"
: "${AGNOSTER_HG_CLEAN_BG:=#22C55E}"


# -----------------------------------------------------
# Virtual Environment
# -----------------------------------------------------

: "${AGNOSTER_VENV_FG:=#FFFFFF}"
: "${AGNOSTER_VENV_BG:=#0EA5E9}"


# -----------------------------------------------------
# Neovim
# -----------------------------------------------------

: "${GEC_NEOVIM_FG:=#FFFFFF}"
: "${GEC_NEOVIM_BG:=#57A143}"


# -----------------------------------------------------
# Python
# -----------------------------------------------------

: "${GEC_PYTHON_FG:=#FFD43B}"
: "${GEC_PYTHON_BG:=#3776AB}"


# -----------------------------------------------------
# Node.js
# -----------------------------------------------------

: "${GEC_NODE_FG:=#FFFFFF}"
: "${GEC_NODE_BG:=#5FA04E}"


# -----------------------------------------------------
# Java
# -----------------------------------------------------

: "${GEC_JAVA_FG:=#FFFFFF}"
: "${GEC_JAVA_BG:=#E76F00}"


# -----------------------------------------------------
# JavaScript
# -----------------------------------------------------

: "${GEC_JAVASCRIPT_FG:=#111111}"
: "${GEC_JAVASCRIPT_BG:=#F7DF1E}"


# -----------------------------------------------------
# .NET
# -----------------------------------------------------

: "${GEC_DOTNET_FG:=#FFFFFF}"
: "${GEC_DOTNET_BG:=#512BD4}"


# -----------------------------------------------------
# npm
# -----------------------------------------------------

: "${GEC_NPM_FG:=#FFFFFF}"
: "${GEC_NPM_BG:=#CB3837}"


# -----------------------------------------------------
# Final Status
# -----------------------------------------------------

: "${GEC_STATUS_FG:=#FFFFFF}"
: "${GEC_STATUS_BG:=#111827}"

: "${GEC_STATUS_ERROR_FG:=#EF4444}"
: "${GEC_STATUS_ROOT_FG:=#FACC15}"
: "${GEC_STATUS_JOB_FG:=#22D3EE}"


# =====================================================
#                 POWERLINE SEGMENT
# =====================================================

prompt_segment() {

    local bg
    local fg

    if [[ -n "$1" ]]; then
        bg="%K{$1}"
    else
        bg="%k"
    fi

    if [[ -n "$2" ]]; then
        fg="%F{$2}"
    else
        fg="%f"
    fi


    # -------------------------------------------------
    # Create the  transition between colours
    # -------------------------------------------------

    if [[ "$CURRENT_BG" != "NONE" && "$1" != "$CURRENT_BG" ]]; then

        echo -n \
            " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "

    else

        echo -n "%{$bg%}%{$fg%} "

    fi


    CURRENT_BG="$1"


    if [[ -n "$3" ]]; then
        echo -n "$3"
    fi
}


# =====================================================
#                  END POWERLINE
# =====================================================

prompt_end() {

    if [[ "$CURRENT_BG" != "NONE" && -n "$CURRENT_BG" ]]; then

        echo -n \
            " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"

    else

        echo -n "%{%k%}"

    fi


    echo -n "%{%f%}"

    CURRENT_BG='NONE'
}


# =====================================================
#                        ARCH
# =====================================================
#
# Displays only:
#
#    Arch
#
# The word "Linux" is intentionally omitted.
#
# =====================================================

prompt_linux() {

    [[ "$GEC_SHOW_LINUX" == "true" ]] || return
    [[ "$(uname -s 2>/dev/null)" == "Linux" ]] || return

    prompt_segment \
        "$GEC_LINUX_BG" \
        "$GEC_LINUX_FG" \
        "$LINUX_CHAR Arch"
}


# =====================================================
#                    DATE + TIME
# =====================================================
#
# Example:
#
# Wednesday 23 September 2026 - 09:21 AM
#
# %A = Wednesday
# %d = 23
# %B = September
# %Y = 2026
# %I = 12-hour clock
# %M = Minutes
# %p = AM / PM
#
# =====================================================


prompt_datetime() {

    local datetime

    datetime=$(date '+%A %d %b %I:%M %p')

    # Change "Sept"
    datetime="${datetime/ Sept }"

    prompt_segment \
        "$GEC_DATETIME_BG" \
        "$GEC_DATETIME_FG" \
        "$datetime"
}

# =====================================================
#                    GIT HELPERS
# =====================================================

git_toplevel() {

    local repo_root


    repo_root=$(
        command git rev-parse \
            --show-toplevel \
            2>/dev/null
    )


    if [[ -z "$repo_root" ]]; then

        repo_root=$(
            command git rev-parse \
                --git-dir \
                2>/dev/null
        )


        if [[ "$repo_root" == "." ]]; then
            repo_root="$PWD"
        fi

    fi


    echo -n "$repo_root"
}


# =====================================================
#                GIT RELATIVE DIRECTORY
# =====================================================

prompt_git_relative() {

    local repo_root
    local path_in_repo


    repo_root=$(git_toplevel)


    path_in_repo=$(
        pwd |
        sed \
            "s/^$(echo "$repo_root" |
            sed 's:/:\\/:g;s/\$/\\$/g')//;s:^/::;s:/$::;"
    )


    if [[ -n "$path_in_repo" ]]; then

        prompt_segment \
            "$AGNOSTER_DIR_BG" \
            "$AGNOSTER_DIR_FG" \
            "$path_in_repo"

    fi
}


# =====================================================
#                         GIT
# =====================================================

prompt_git() {

    (( $+commands[git] )) || return


    if [[ \
        "$(command git config \
        --get oh-my-zsh.hide-status \
        2>/dev/null)" == "1" \
    ]]; then

        return

    fi


    local PL_BRANCH_CHAR="$BRANCH"

    local ref
    local dirty
    local mode
    local repo_path


    # -------------------------------------------------
    # Check Git repository
    # -------------------------------------------------

    if [[ \
        "$(command git rev-parse \
        --is-inside-work-tree \
        2>/dev/null)" == "true" \
    ]]; then


        repo_path=$(
            command git rev-parse \
                --git-dir \
                2>/dev/null
        )


        dirty=$(parse_git_dirty)


        ref=$(
            command git symbolic-ref \
                HEAD \
                2>/dev/null
        ) || \
        ref="◈ $(
            command git describe \
                --exact-match \
                --tags \
                HEAD \
                2>/dev/null
        )" || \
        ref="➦ $(
            command git rev-parse \
                --short \
                HEAD \
                2>/dev/null
        )"


        # -------------------------------------------------
        # Git colour
        # -------------------------------------------------

        if [[ -n "$dirty" ]]; then

            prompt_segment \
                "$AGNOSTER_GIT_DIRTY_BG" \
                "$AGNOSTER_GIT_DIRTY_FG"

        else

            prompt_segment \
                "$AGNOSTER_GIT_CLEAN_BG" \
                "$AGNOSTER_GIT_CLEAN_FG"

        fi


        # -------------------------------------------------
        # Ahead / Behind
        # -------------------------------------------------

        if [[ "$AGNOSTER_GIT_BRANCH_STATUS" == "true" ]]; then

            local ahead
            local behind


            ahead=$(
                command git log \
                    --oneline \
                    '@{upstream}..' \
                    2>/dev/null
            )


            behind=$(
                command git log \
                    --oneline \
                    '..@{upstream}' \
                    2>/dev/null
            )


            if [[ -n "$ahead" && -n "$behind" ]]; then

                PL_BRANCH_CHAR=$'\u21c5'

            elif [[ -n "$ahead" ]]; then

                PL_BRANCH_CHAR=$'\u21b1'

            elif [[ -n "$behind" ]]; then

                PL_BRANCH_CHAR=$'\u21b0'

            fi
        fi


        # -------------------------------------------------
        # Git operations
        # -------------------------------------------------

        if [[ -e "${repo_path}/BISECT_LOG" ]]; then

            mode=" <B>"

        elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then

            mode=" >M<"

        elif [[ \
            -e "${repo_path}/rebase" || \
            -e "${repo_path}/rebase-apply" || \
            -e "${repo_path}/rebase-merge" || \
            -e "${repo_path}/../.dotest" \
        ]]; then

            mode=" >R>"

        fi


        # -------------------------------------------------
        # Git file status
        # -------------------------------------------------

        setopt promptsubst

        autoload -Uz vcs_info


        zstyle ':vcs_info:*' enable git
        zstyle ':vcs_info:*' get-revision true
        zstyle ':vcs_info:*' check-for-changes true

        zstyle ':vcs_info:*' stagedstr '✚'
        zstyle ':vcs_info:*' unstagedstr '±'

        zstyle ':vcs_info:*' formats ' %u%c'
        zstyle ':vcs_info:*' actionformats ' %u%c'


        vcs_info


        # -------------------------------------------------
        # GitHub Icon + Git branch
        # -------------------------------------------------

        echo -n \
            "$GITHUB_CHAR ${${ref:gs/%/%%}/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"


        # -------------------------------------------------
        # Git relative directory
        # -------------------------------------------------

        if [[ "$AGNOSTER_GIT_INLINE" == "true" ]]; then
            prompt_git_relative
        fi

    fi
}


# =====================================================
#                 CURRENT DIRECTORY
# =====================================================

prompt_dir() {

    if [[ "$AGNOSTER_GIT_INLINE" == "true" ]] && \
       command git rev-parse \
           --is-inside-work-tree \
           >/dev/null 2>&1; then


        prompt_segment \
            "$AGNOSTER_DIR_BG" \
            "$AGNOSTER_DIR_FG" \
            "$(git_toplevel |
            sed "s:^$HOME:~:")"


    else


        prompt_segment \
            "$AGNOSTER_DIR_BG" \
            "$AGNOSTER_DIR_FG" \
            '%~'


    fi
}


# =====================================================
#                  VIRTUAL ENVIRONMENT
# =====================================================

prompt_virtualenv() {

    if [[ \
        -n "$CONDA_DEFAULT_ENV" && \
        -z "$CONDA_PROMPT_MODIFIER" \
    ]]; then

        prompt_segment \
            "$AGNOSTER_VENV_BG" \
            "$AGNOSTER_VENV_FG" \
            "🐍 ${CONDA_DEFAULT_ENV:t:gs/%/%%}"

    fi


    if [[ \
        -n "$VIRTUAL_ENV" && \
        -n "$VIRTUAL_ENV_DISABLE_PROMPT" \
    ]]; then

        prompt_segment \
            "$AGNOSTER_VENV_BG" \
            "$AGNOSTER_VENV_FG" \
            "(${VIRTUAL_ENV:t:gs/%/%%})"

    fi
}


# =====================================================
#                       NEOVIM
# =====================================================
#
# Displays the Neovim logo and version only:
#
#    v0.12.5
#
# The word "Neovim" is intentionally omitted.
#
# =====================================================

prompt_neovim() {

    (( $+commands[nvim] )) || return

    if [[ \
        "$GEC_SHOW_NEOVIM_ALWAYS" != "true" && \
        -z "$NVIM" \
    ]]; then

        return

    fi

    local version=""

    if [[ "$GEC_SHOW_VERSIONS" == "true" ]]; then

        version=$(
            command nvim \
                --version \
                2>/dev/null |
            head -n1 |
            awk '{print $2}'
        )

    fi

    prompt_segment \
        "$GEC_NEOVIM_BG" \
        "$GEC_NEOVIM_FG" \
        "$NEOVIM_CHAR ${version}"
}


# =====================================================
#                       PYTHON
# =====================================================

prompt_python() {

    local python_cmd=""


    if (( $+commands[python3] )); then

        python_cmd="python3"

    elif (( $+commands[python] )); then

        python_cmd="python"

    else

        return

    fi


    # -------------------------------------------------
    # Detect Python project
    # -------------------------------------------------

    local -a python_files

    python_files=(
        *.py(N)
    )


    if [[ \
        ! -f pyproject.toml && \
        ! -f requirements.txt && \
        ! -f setup.py && \
        ! -f setup.cfg && \
        ! -f Pipfile && \
        ! -f poetry.lock \
    ]]; then

        (( ${#python_files[@]} > 0 )) || return

    fi


    local version=""


    if [[ "$GEC_SHOW_VERSIONS" == "true" ]]; then

        version=$(
            command "$python_cmd" \
                --version \
                2>&1 |
            awk '{print $2}'
        )

    fi


    prompt_segment \
        "$GEC_PYTHON_BG" \
        "$GEC_PYTHON_FG" \
        "$PYTHON_CHAR Python ${version}"
}


# =====================================================
#                       NODE.JS
# =====================================================

prompt_node() {

    (( $+commands[node] )) || return


    # -------------------------------------------------
    # Detect Node project
    # -------------------------------------------------

    if [[ \
        ! -f package.json && \
        ! -f package-lock.json && \
        ! -f yarn.lock && \
        ! -f pnpm-lock.yaml && \
        ! -d node_modules \
    ]]; then

        return

    fi


    local version=""


    if [[ "$GEC_SHOW_VERSIONS" == "true" ]]; then

        version=$(
            command node \
                --version \
                2>/dev/null
        )

    fi


    prompt_segment \
        "$GEC_NODE_BG" \
        "$GEC_NODE_FG" \
        "$NODE_CHAR Node.js ${version}"
}


# =====================================================
#                    JAVASCRIPT
# =====================================================

prompt_javascript() {

    local -a javascript_files


    javascript_files=(
        *.js(N)
        *.mjs(N)
        *.cjs(N)
        *.jsx(N)
    )


    if [[ ! -f package.json ]]; then

        (( ${#javascript_files[@]} > 0 )) || return

    fi


    prompt_segment \
        "$GEC_JAVASCRIPT_BG" \
        "$GEC_JAVASCRIPT_FG" \
        "$JAVASCRIPT_CHAR JavaScript"
}


# =====================================================
#                         NPM
# =====================================================

prompt_npm() {

    (( $+commands[npm] )) || return


    if [[ \
        ! -f package.json && \
        ! -f package-lock.json && \
        ! -f npm-shrinkwrap.json \
    ]]; then

        return

    fi


    local version=""


    if [[ "$GEC_SHOW_VERSIONS" == "true" ]]; then

        version=$(
            command npm \
                --version \
                2>/dev/null
        )

    fi


    prompt_segment \
        "$GEC_NPM_BG" \
        "$GEC_NPM_FG" \
        "$NPM_CHAR npm ${version}"
}


# =====================================================
#                         JAVA
# =====================================================

prompt_java() {

    (( $+commands[java] )) || return


    local -a java_files


    java_files=(
        *.java(N)
    )


    if [[ \
        ! -f pom.xml && \
        ! -f build.gradle && \
        ! -f build.gradle.kts && \
        ! -f settings.gradle && \
        ! -f settings.gradle.kts && \
        ! -f gradlew \
    ]]; then

        (( ${#java_files[@]} > 0 )) || return

    fi


    local version=""


    if [[ "$GEC_SHOW_VERSIONS" == "true" ]]; then

        version=$(
            command java \
                -version \
                2>&1 |
            head -n1 |
            sed -E 's/.*version "([^"]+)".*/\1/'
        )

    fi


    prompt_segment \
        "$GEC_JAVA_BG" \
        "$GEC_JAVA_FG" \
        "$JAVA_CHAR Java ${version}"
}


# =====================================================
#                         .NET
# =====================================================

prompt_dotnet() {

    (( $+commands[dotnet] )) || return


    local -a dotnet_files


    dotnet_files=(
        *.csproj(N)
        *.fsproj(N)
        *.vbproj(N)
        *.sln(N)
    )


    if [[ \
        ! -f global.json && \
        ! -f Directory.Build.props \
    ]]; then

        (( ${#dotnet_files[@]} > 0 )) || return

    fi


    local version=""


    if [[ "$GEC_SHOW_VERSIONS" == "true" ]]; then

        version=$(
            command dotnet \
                --version \
                2>/dev/null
        )

    fi


    prompt_segment \
        "$GEC_DOTNET_BG" \
        "$GEC_DOTNET_FG" \
        "$DOTNET_CHAR .NET ${version}"
}


# =====================================================
#                     MERCURIAL
# =====================================================

prompt_hg() {

    (( $+commands[hg] )) || return


    command hg root >/dev/null 2>&1 || return


    local branch
    local status


    branch=$(
        command hg branch \
            2>/dev/null
    )


    status=$(
        command hg status \
            2>/dev/null
    )


    # -------------------------------------------------
    # Changed repository
    # -------------------------------------------------

    if [[ -n "$status" ]]; then

        prompt_segment \
            "$AGNOSTER_HG_CHANGED_BG" \
            "$AGNOSTER_HG_CHANGED_FG" \
            "☿ $branch ±"


    # -------------------------------------------------
    # Clean repository
    # -------------------------------------------------

    else

        prompt_segment \
            "$AGNOSTER_HG_CLEAN_BG" \
            "$AGNOSTER_HG_CLEAN_FG" \
            "☿ $branch"

    fi
}


# =====================================================
#                   FINAL STATUS
# =====================================================
#
# This is deliberately called LAST.
#
# Failed command:
#
#    ...  ✘ 
#
# Successful command:
#
#    No red X is displayed.
#
# =====================================================

prompt_status_end() {

    local symbols=""
    local error_symbol="$CROSS"


    # -------------------------------------------------
    # Root
    # -------------------------------------------------

    if [[ "$UID" -eq 0 ]]; then

        symbols+="%F{$GEC_STATUS_ROOT_FG}$LIGHTNING%F{$GEC_STATUS_FG}"

    fi


    # -------------------------------------------------
    # Background Jobs
    # -------------------------------------------------

    if [[ "$(jobs -l | wc -l)" -gt 0 ]]; then

        [[ -n "$symbols" ]] && symbols+=" "

        symbols+="%F{$GEC_STATUS_JOB_FG}$GEAR%F{$GEC_STATUS_FG}"

    fi


    # -------------------------------------------------
    # Previous command failed
    #
    # The red X is deliberately added LAST.
    # -------------------------------------------------

    if [[ "$RETVAL" -ne 0 ]]; then

        if [[ "$AGNOSTER_STATUS_RETVAL_NUMERIC" == "true" ]]; then
            error_symbol="$RETVAL"
        fi


        [[ -n "$symbols" ]] && symbols+=" "


        symbols+="%F{$GEC_STATUS_ERROR_FG}$error_symbol%F{$GEC_STATUS_FG}"

    fi


    # -------------------------------------------------
    # Draw final status segment
    # -------------------------------------------------

    if [[ -n "$symbols" ]]; then

        prompt_segment \
            "$GEC_STATUS_BG" \
            "$GEC_STATUS_FG" \
            "$symbols"

    fi
}


# =====================================================
#                     MAIN PROMPT
# =====================================================

build_prompt() {

    # Save previous command exit status immediately.
    RETVAL=$?


    # Reset Powerline state.
    CURRENT_BG='NONE'


    # -------------------------------------------------
    # Linux
    # -------------------------------------------------

    prompt_linux


    # -------------------------------------------------
    # Date + Time
    # -------------------------------------------------

    prompt_datetime


    # -------------------------------------------------
    # Virtual Environment
    # -------------------------------------------------

    prompt_virtualenv


    # -------------------------------------------------
    # Directory
    # -------------------------------------------------

    prompt_dir


    # -------------------------------------------------
    # Development Tools / Languages
    # -------------------------------------------------

    prompt_neovim

    prompt_python

    prompt_node

    prompt_javascript

    prompt_npm

    prompt_java

    prompt_dotnet


    # -------------------------------------------------
    # Git
    # -------------------------------------------------

    prompt_git


    # -------------------------------------------------
    # Mercurial
    # -------------------------------------------------

    prompt_hg


    # -------------------------------------------------
    # Status MUST remain last.
    #
    # This puts the red ✘ at the end.
    # -------------------------------------------------

    prompt_status_end


    # -------------------------------------------------
    # Close final 
    # -------------------------------------------------

    prompt_end
}


# =====================================================
#                    FINAL PROMPT
# =====================================================

PROMPT='%{%f%b%k%}$(build_prompt) '