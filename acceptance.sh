BOXES=( default centos-5-x64 centos-6-x64 debian-7-x64 debian-8-x64 debian-9-x64 ubuntu-1404-x64 ubuntu-1604-x64 scientific-7-x64 scientific-6-x64 )
for BOX in "${BOXES[@]}"; do
  PUPPET_INSTALL_TYPE="agent" BEAKER_set="${BOX}" bundle exec rake beaker
done
