function fish_prompt
    set -l __last_status $status

    if not set -q -g __fish_prompt_functions
        set -g __fish_prompt_functions

        function _git_branch_name
            set -l branch (git symbolic-ref --quiet HEAD 2>/dev/null)
            if set -q branch[1]
                echo (string replace -r '^refs/heads/' '' $branch)
            else
                echo (git rev-parse --short HEAD 2>/dev/null)
            end
        end

        function _is_git_dirty
            not command git diff-index --cached --quiet HEAD -- &>/dev/null
            or not command git diff --no-ext-diff --quiet --exit-code &>/dev/null
        end
    end

    set -l cyan (set_color -o cyan)
    set -l yellow (set_color -o yellow)
    set -l red (set_color -o red)
    set -l green (set_color -o green)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)

    set -l arrow_color "$green"
    if test $__last_status != 0
        set arrow_color "$red"
    end

    set -l arrow "$arrow_color> "
    if fish_is_root_user
        set arrow "$arrow_color# "
    end

    set -l cwd "$cyan$(prompt_pwd)"

    set -l repo_info
    set -l repo_branch "$red$(_git_branch_name)"

    set repo_info "$blue($repo_branch$blue)"

    if _is_git_dirty
        set -l dirty "$yellow ✗"
        set repo_info "$repo_info$dirty"
    end

    echo -n "$cwd$repo_info $arrow$normal"
end
