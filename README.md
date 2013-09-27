debian-node-nginx-server-
=========================

scripts to set up a debian wheezy server with node, mongo, nginx and pm2 with socket.io support

Setting up a debian server using rackspace can be a bit of a challenge, especially when it isn't your day job. So here's the results of a few weeks of mucking around trying to get to a node build that will allow for a rebootable box.

Includes nginx, node, mongodb, pm2 (to keep node.js processes running), coffeescript... etc. Also enough init.d scripts to get you running so if you reboot, node processess restart automatically.

Hope this helps someone. ~Ed
