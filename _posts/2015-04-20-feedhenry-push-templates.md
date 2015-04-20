---
layout: news
section: news
title: AeroGear quick start push Templates
author: edewit
---

Currently in software development the biggest challenge is integrating. A lot of what we do involves integrating with other platforms or libraries. Knowing how to integrate is important, so here I'm going to show how to integrate the UPS (Unified Push Server) with Feedhenry. To make things even easier we created a Template that you can use as a starting point for your application that contain all the parts you'll need.

Start by creating a new project and select "Sample Projects" and then find the Project named: `Push Hello World`. Click choose pick a name and hit create.

![choose template](/img/news/2015-04-20-feedhenry-push-templates/1.png)

Now you have 3 projects one server and two client projects. The server is a simple CRUD application for Categories. The client project called console is the "management inteface" here you can create and delete Categories. These categories are used by the mobile client to "subscribe" to. For example I have a sports news site and I push messages about different sports to the mobile users. The users "subscribe" to different sports they want to receive notifications about.

With this generated project all that is left todo is connect the Unified Push Server to this project, first go to openshift.com and create an UPS instance, search on AeroGear pick a name and "Create Application". For more information on how to set up a unified push server on openshift have a look at our [documentation](/docs/unifiedpush/ups_userguide/index/#openshift). Now you have a running UPS on openshift you need to login and create an "application" that will be used by your Feedhenry projects to send push notifications. Note down the `Application ID`, `Master Secret` and the `Server URL` as we going to need those later on.

Next we need to do two things we need create a "Service connector" for UPS and we need to tell the Cloud App the `GUID` of the "Service connector" so that it can use this to send messages to UPS. First we setup the "Service connector" to connect to our openshift UPS instance, go to the `Services & APIs` tab and click `Provision mBaaS Service/API`:

![Provision mBaaS Service](/img/news/2015-04-20-feedhenry-push-templates/3.png)

Then choose `AeroGear Push Service`, give it a name and click `Next`, fill in the `Server URL`, `Application ID` and `Master Secret` and click `Next` now it will create your "Service connector" after that is done go back to your project, here we need to add the service so that we can use it click the "+" in the mBaas Services box in the overview page:

![add mBaas Services](/img/news/2015-04-20-feedhenry-push-templates/2.png)

Select the created "Service connector" and then the "Associate Service" button. Now you'll see the "Service Connector" in the "mBaas Services" column. Let's configure the "Cloud App" to use this "Service Connector", for that we need to the GUID of the "Service Connector", click on it and you will see the info page:

![copy GUID](/img/news/2015-04-20-feedhenry-push-templates/4.png)

On the info page copy the `Service ID` and under access control add you project, then click save.

Then in the project click on the "Cloud App" and select "Environment variables" from the sidebar. Click "Add Variable" and enter `AEROGEAR_SERVICE_GUID` for name and paste the "Service connector" for "Development" then "Push Environment Variables" to publish these.

Now that that is all setup, the "Cloud App" can use the "GUID" to fetch the "Service Connector", that connects to UPS to send the messages. Let's fire up a browser and open the "Console", create a couple of Categories for instance: Football, Rugby and Basketball. Now build and install the mobile client on a device and select the categories you want to receive. Send a message and see how they arrive on the mobile client.

You can use and extend this template for your own use case. Hope you like it.