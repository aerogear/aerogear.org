---
layout: news
section: news
title: AeroGear quick start push Templates
author: edewit
---

Currently in software development the biggest challenge is integrating. A lot of what we do involves integrating with other platforms or libraries. Knowing how to integrate is important, so here I'm going to show how to integrate the Unified Push Server (UPS) with Feedhenry, for adding push notification support. To make things even easier we created a Feedhenry Template that you can use as a starting point for your application that contain all the parts you'll need.

To illustrate how to use the FeedHenry Template for push notifications, you will build a set of sample applications for receiving sports news. You will use a centralized cloud application that integrates with both a push server as well as any client applications. The centralized cloud app contains various categories (i.e. different sports) and news stories associated with one or more categories. There are also two client applications: 

* Console web application: Lets administrators create and update the category list, as well as create news stories on the centralized cloud app
* Mobile application: Lets users subscribe to any of the available categories and receive a push notification whenever a new story is posted with that category

To build a project based on this template:

1. Create a new project.
1. Click *Sample Projects*, and then find the Project named: *Push Hello World*.
1. Click select type a name, and then click *create*.

![choose template](/img/news/2015-04-20-feedhenry-push-templates/1.png)

Now you have three apps one Cloud Code App and two Client Apps.

![app structure](/img/news/2015-04-20-feedhenry-push-templates/5.png)

The _Push Cloud App_ is a simple server-side CRUD application for categories. The _Push Console App_ is a "management inteface" where you create and delete these categories. These categories are used by the _Push Notifications Mobile Client_ to "subscribe" to. For example I have a sports news site and I push messages about different sports to the mobile users. The users _subscribes_ to different sports they want to receive notifications about.

With this generated project all that is left todo is connect the Unified Push Server to this project, first go to openshift.com and create an UPS instance, search on AeroGear pick a name and "Create Application". For more information on how to set up a unified push server on openshift have a look at our [documentation](/docs/unifiedpush/ups_userguide/index/#openshift). Now you have a running UPS on openshift you need to login and create an "application" that will be used by your Feedhenry apps to send push notifications. Note down the `Application ID`, `Master Secret` and the `Server URL` as we going to need those later on.

![Application settings](/img/news/2015-04-20-feedhenry-push-templates/10.png)

For the clients that we want to use (e.g. Android iOS) we need to create variants, for more information on how to do this have a look at the UPS documentation for [Android](https://aerogear.org/docs/unifiedpush/aerogear-push-android/) and [iOS](https://aerogear.org/docs/unifiedpush/aerogear-push-ios/)

Next we need to do two things we need create a "Service connector" for UPS and we need to tell the Cloud App the `GUID` of the "Service connector" so that it can use this to send messages to UPS. First we setup the "Service connector" to connect to our openshift UPS instance, go to the `Services & APIs` tab and click `Provision mBaaS Service/API`:

![Provision mBaaS Service](/img/news/2015-04-20-feedhenry-push-templates/3.png)

Then choose `AeroGear Push Service`, give it a name and click `Next`, fill in the `Server URL`, `Application ID` and `Master Secret` and click `Next` now it will create your "Service connector"

![create service connector](/img/news/2015-04-20-feedhenry-push-templates/7.png)
 
 After that is done go back to your project, here we need to add the service so that we can use it click the "+" in the mBaas Services box in the overview page:

![add mBaas Services](/img/news/2015-04-20-feedhenry-push-templates/2.png)

Select the created "Service connector" and then the "Associate Service" button. Now you'll see the "Service Connector" in the "mBaas Services" column. Let's configure the "Cloud App" to use this "Service Connector", for that we need to the GUID of the "Service Connector", click on it and you will see the info page:

![copy GUID](/img/news/2015-04-20-feedhenry-push-templates/4.png)

On the info page copy the `Service ID` and under access control add you project, then click save.

Then in the project click on the "Cloud App" and select "Environment variables" from the sidebar. Click "Add Variable" and enter `AEROGEAR_SERVICE_GUID` for name and paste the "Service connector" for "Development" then "Push Environment Variables" to publish these.

![environment variable](/img/news/2015-04-20-feedhenry-push-templates/6.png)

Now that that is all setup, the "Cloud App" can use the "GUID" to fetch the "Service Connector", that connects to UPS to send the messages.

Let's fire up a browser and open the _Push Console App_ to create a couple of categories for instance: Football, Rugby and Basketball: 

![console](/img/news/2015-04-20-feedhenry-push-templates/8.png)

Now go to your _Push Notifications Mobile Client_ and open the file called `push-config.json`. You'll need to update the _Variant ID_ and _Variant Secret_ for each platform, so that it can register itself with the UnifiedPush Server in order to receive messages. For Android you also need to specify the _projectID_ inside of that JSON file.  Finally build and install the _Push Notifications Mobile Client_ on a device and select the categories you want to receive.


Now go back to the _Push Console App_ and send a message. If all worked well, you will see how the push notifications arrive on the mobile client. 

![mobile app received notification](/img/news/2015-04-20-feedhenry-push-templates/9.png)

You can use and extend this template for your own use case. Hope you like it.
