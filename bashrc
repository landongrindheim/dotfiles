# vim: set filetype=sh:
set +f

for config_file in $HOME/.bashrc.d/[0-9]*; do
  source "$config_file"
done

export BASH_SILENCE_DEPRECATION_WARNING=1
