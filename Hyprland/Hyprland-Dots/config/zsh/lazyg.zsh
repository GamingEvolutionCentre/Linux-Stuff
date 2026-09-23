lazyg() {
    case "$1" in

        # ---------------------------------------------------------
        # Status
        # ---------------------------------------------------------
        s|status)
            git status
            ;;

        short)
            git status --short --branch
            ;;


        # ---------------------------------------------------------
        # Add / Stage
        # ---------------------------------------------------------
        a|add)
            shift
            if [[ $# -eq 0 ]]; then
                git add .
            else
                git add "$@"
            fi
            ;;

        aa)
            git add -A
            ;;

        unstage)
            shift
            git restore --staged "$@"
            ;;


        # ---------------------------------------------------------
        # Commit
        # ---------------------------------------------------------
        c|commit)
            shift
            git commit -m "$*"
            ;;

        amend)
            shift
            if [[ $# -eq 0 ]]; then
                git commit --amend
            else
                git commit --amend -m "$*"
            fi
            ;;

        amend-no-edit)
            git commit --amend --no-edit
            ;;


        # ---------------------------------------------------------
        # Push / Pull / Fetch
        # ---------------------------------------------------------
        p|push)
            git push
            ;;

        pf|force-push)
            git push --force-with-lease
            ;;

        pull)
            git pull
            ;;

        fetch)
            git fetch --all --prune
            ;;


        # ---------------------------------------------------------
        # Clone
        # ---------------------------------------------------------
        clone)
            shift
            git clone "$@"
            ;;


        # ---------------------------------------------------------
        # Branches
        # ---------------------------------------------------------
        b|branch)
            git branch
            ;;

        ba)
            git branch -a
            ;;

        bn)
            shift
            git branch "$1"
            ;;

        bd)
            shift
            git branch -d "$1"
            ;;

        bdf)
            shift
            git branch -D "$1"
            ;;


        # ---------------------------------------------------------
        # Checkout / Switch
        # ---------------------------------------------------------
        co|checkout)
            shift
            git checkout "$@"
            ;;

        sw|switch)
            shift
            git switch "$@"
            ;;

        new)
            shift
            git switch -c "$1"
            ;;


        # ---------------------------------------------------------
        # Merge / Rebase
        # ---------------------------------------------------------
        merge)
            shift
            git merge "$@"
            ;;

        rb|rebase)
            shift
            git rebase "$@"
            ;;

        rbc)
            git rebase --continue
            ;;

        rba)
            git rebase --abort
            ;;


        # ---------------------------------------------------------
        # Logs
        # ---------------------------------------------------------
        log)
            git log \
                --pretty=format:'%C(yellow)%h%Creset %C(cyan)%ad%Creset %C(green)%an%Creset %s' \
                --date=short
            ;;

        graph)
            git log \
                --graph \
                --decorate \
                --all \
                --oneline
            ;;

        last)
            git log -1 --stat
            ;;


        # ---------------------------------------------------------
        # Diff
        # ---------------------------------------------------------
        diff)
            git diff
            ;;

        staged)
            git diff --staged
            ;;


        # ---------------------------------------------------------
        # Restore
        # ---------------------------------------------------------
        restore)
            shift
            git restore "$@"
            ;;


        # ---------------------------------------------------------
        # Stash
        # ---------------------------------------------------------
        stash)
            shift
            if [[ $# -eq 0 ]]; then
                git stash
            else
                git stash push -m "$*"
            fi
            ;;

        pop)
            git stash pop
            ;;

        stashes)
            git stash list
            ;;

        stashdrop)
            shift
            git stash drop "$@"
            ;;


        # ---------------------------------------------------------
        # Remote
        # ---------------------------------------------------------
        remote)
            git remote -v
            ;;

        remotes)
            git remote -v
            ;;


        # ---------------------------------------------------------
        # Tags
        # ---------------------------------------------------------
        tags)
            git tag
            ;;

        tag)
            shift
            git tag "$@"
            ;;


        # ---------------------------------------------------------
        # Reset / Undo
        # ---------------------------------------------------------
        undo)
            git reset --soft HEAD~1
            ;;

        reset)
            shift
            git reset "$@"
            ;;

        hard-reset)
            shift
            git reset --hard "$@"
            ;;


        # ---------------------------------------------------------
        # Clean
        # ---------------------------------------------------------
        clean)
            # Preview only
            git clean -nd
            ;;

        clean-confirm)
            git clean -fd
            ;;


        # ---------------------------------------------------------
        # Repository information
        # ---------------------------------------------------------
        root)
            git rev-parse --show-toplevel
            ;;

        info)
            echo "Repository:"
            git rev-parse --show-toplevel 2>/dev/null || return

            echo
            echo "Branch:"
            git branch --show-current

            echo
            echo "Status:"
            git status --short --branch

            echo
            echo "Remotes:"
            git remote -v
            ;;


        # ---------------------------------------------------------
        # Help
        # ---------------------------------------------------------
        help|--help|-h|"")
            echo "lazyg - Git CLI shortcuts"
            echo
            echo "Usage: lazyg <command>"
            echo
            echo "Status:"
            echo "  s, status             git status"
            echo "  short                 compact status"
            echo
            echo "Stage:"
            echo "  a [files]             git add"
            echo "  aa                    git add -A"
            echo "  unstage FILE          unstage file"
            echo
            echo "Commit:"
            echo "  c MESSAGE             commit"
            echo "  amend                 amend commit"
            echo "  amend-no-edit         amend without changing message"
            echo
            echo "Remote:"
            echo "  p                     push"
            echo "  pf                    force push safely"
            echo "  pull                  pull"
            echo "  fetch                 fetch and prune"
            echo
            echo "Branches:"
            echo "  b                     branches"
            echo "  ba                    all branches"
            echo "  bn NAME               create branch"
            echo "  bd NAME               delete branch"
            echo "  sw NAME               switch branch"
            echo "  new NAME              create + switch branch"
            echo
            echo "History:"
            echo "  log                   commit log"
            echo "  graph                 branch graph"
            echo "  last                  last commit"
            echo
            echo "Changes:"
            echo "  diff                  unstaged diff"
            echo "  staged                staged diff"
            echo "  restore FILE          restore file"
            echo
            echo "Stash:"
            echo "  stash                 stash changes"
            echo "  pop                   restore stash"
            echo "  stashes               list stashes"
            echo
            echo "Other:"
            echo "  undo                  undo last commit"
            echo "  clean                 preview clean"
            echo "  clean-confirm         delete untracked files"
            echo "  root                  repository root"
            echo "  info                  repository information"
            ;;

        *)
            echo "Unknown lazyg command: $1"
            echo "Run 'lazyg help' for available commands."
            return 1
            ;;
    esac
}