# Testplan: Base box Vagrant (WISA)
*Author: Matthias Van De Velde*

1. Change `blogdemo` to `$true` in vagrant-hosts.yml if it's not already.
2. `vagrant up wisastack`
3. Wait for the box to be fully booted and provisioned.
4. Surf to 192.168.248.10 on your host machine.
5. You should  see the front page of a blog
