debian-node-nginx-server
=========================

scripts to set up a debian wheezy server with node, mongo, nginx and pm2 with socket.io support - tested using a rackspace build.

Setting up a debian server using rackspace can be a bit of a challenge, especially when it isn't your day job. So here's the results of a few weeks of mucking around trying to get to a node build that will allow for a rebootable box.

Includes nginx, node, mongodb, pm2 (to keep node.js processes running), coffeescript... etc. Also enough init.d scripts to get you running so if you reboot, node processess restart automatically.  Plus a link to a socket.io demo in case that gets you moving.

I'm no git expert.  And there are only so many files here, so I'd say just copy and paste them using an editor of choice and then save them using the folder structure seen here.  Still looking at well under an hour, start to finish.

Instructions:

- Copy down usr/local/sbin/nodeServerSetup.sh and run that sucker.
```
> chmod +x nodeServerSetup.sh
> nodeServerSetup.sh
```

- Now sit around and hit enter or 'y' a few times.

- Want a demo app?  Make a dir where you want to put it and do this:
```
> git clone https://github.com/mmukhin/psitsmike_example_1.git
> cd psitsmike_example_1
> npm install
```

- Edit the index.html file and replace 'localhost' with your servers ip address.  Then fire it up using pm2.
```
> pm2 start app.js
```

- Copy down the nginx config files - you'll have to create a conf.d folder.
- Copy down the init.d scripts for nginx and pm2 to /etc/init.d/ and then configure then to run on startup.
```
> update-rc.d pm2-init.sh defaults
> update-rc.d nginx defaults
```

Now if you wanna, you can edit the /etc/mongod.conf file at this point to enable authentication and make it its own master.  Totally up to you.  If you are into that (and we are), then add these lines:
auth = true
master = true


- At this point, we should be ready to go.  Not even kidding.  Reboot this sucker.
```
> reboot
```

Hope this helps someone. ~Ed
