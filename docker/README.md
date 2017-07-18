# AeroGear.org Docker instructions

You may build this via
```
docker build --tag aerogear.org .
```

If you want to edit files loclaly you will need to mount your volume at /home/aerogear/aerogear

For example : 
``` 
docker run --rm -it -p4000:4000 -v /home/summers/Projects/aerogear.org:/home/aerogear/aerogear aerogear.org 
```

However this should be a CLEAN checkout of aerogear.org, otherwise the vendor and bundler dependencies will conflict with those installed in the host system.