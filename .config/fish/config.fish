if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

if not set -q SSH_AUTH_SOCK
  eval (ss-agent -c)
end
ssh-add ~/.ssh/id_work 2>/dev/null
