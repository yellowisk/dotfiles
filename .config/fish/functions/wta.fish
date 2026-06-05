function wta --description "git worktree add + copy .env from repo root"
    set usage "
  Usage:  wta <branch> <path>

  Args:
    branch   name of the new branch to create
    path     directory where the worktree will be checked out

  Example:
    wta feat/my-feature ../hireflow-my-feature
"

    if test (count $argv) -eq 0
        echo "error: missing arguments"
        echo $usage
        return 1
    end

    if test (count $argv) -eq 1
        echo "error: missing <path> — got branch='$argv[1]' but no path"
        echo $usage
        return 1
    end

    if test (count $argv) -gt 2
        echo "error: too many arguments (expected 2, got "(count $argv)")"
        echo $usage
        return 1
    end

    set branch $argv[1]
    set path $argv[2]

    if test -z "$branch"
        echo "error: <branch> cannot be empty"
        echo $usage
        return 1
    end

    if test -z "$path"
        echo "error: <path> cannot be empty"
        echo $usage
        return 1
    end

    set root (git rev-parse --show-toplevel 2>/dev/null)
    if test $status -ne 0
        echo "error: not inside a git repository"
        return 1
    end

    git worktree add -b $branch $path
    or return 1

    if test -f "$root/.env"
        cp "$root/.env" "$path/.env"
        echo "Copied .env → $path/.env"
    else
        echo "No .env found in $root, skipping"
    end
end
