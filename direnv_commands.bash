eval "$(direnv hook zsh)"
direnv reload
direnv allow
direnv allow .
direnv allow .env
direnv allow .env.local
direnv allow .env.development
direnv allow .env.production
echo $TEST_VAR