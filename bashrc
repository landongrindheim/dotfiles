# vim: set filetype=sh:

for config_file in $HOME/.bashrc.d/[0-9]*; do
  source "$config_file"
done
