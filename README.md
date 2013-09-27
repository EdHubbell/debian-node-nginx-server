debian-node-nginx-server
=========================

scripts to set up a debian wheezy server with node, mongo, nginx and pm2 with socket.io support

Setting up a debian server using rackspace can be a bit of a challenge, especially when it isn't your day job. So here's the results of a few weeks of mucking around trying to get to a node build that will allow for a rebootable box.

Includes nginx, node, mongodb, pm2 (to keep node.js processes running), coffeescript... etc. Also enough init.d scripts to get you running so if you reboot, node processess restart automatically.  Plus a link to a socket.io demo in case that gets you moving.

I'm no git expert.  And there are only so many files here, so I'd say just copy and paste them using an editor of choice and then save them using the folder structure seen here.  Still looking at well under an hour, start to finish.

Instructions:
- copy down usr/local/sbin/nodeServerSetup.sh
> chmod +x nodeServerSetup.sh
> nodeServerSetup.sh
- now sit around and hit enter or 'y' a few times.

- want a demo app?  make a dir where you want to put it and do this:
> git clone https://github.com/mmukhin/psitsmike_example_1.git
> cd psitsmike_example_1
> npm install
- edit the index.html file and replace 'localhost' with your servers ip address.
> pm2 start app.js

- copy down the nginx config files - you'll have to create a conf.d folder.
- copy down the init.d scripts for nginx and pm2 to /etc/init.d/
> update-rc.d pm2-init.sh defaults
> update-rc.d nginx defaults
- at this point, we should be ready to go.  not even kidding.  reboot this sucker.
> reboot

Hope this helps someone. ~Ed
