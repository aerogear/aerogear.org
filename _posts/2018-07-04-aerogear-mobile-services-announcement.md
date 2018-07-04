---
layout: news
section: news
title: Announcing AeroGear Mobile Services on OpenShift
author: aerogear
---

Today, the AeroGear Community is delighted to announce the availability of a suite of Mobile Services, which provides simple solutions to common development challenges faced by mobile developers. After six months of development, this moves AeroGear from being a project primarily focused on Push Notifications to a vision for Cloud Native Mobile and Modern App Development. With OpenShift's Container technology providing  a secure, scalable backend platform, mobile developers can use a range of native ([iOS](/sdks/ios/) & [Android](/sdks/android/)) and hybrid ([Xamarin](/sdks/xamarin/) & [Cordova](/sdks/cordova/)) client SDKs to create secure, high quality apps and makes it easy to add features such as Push Notifications or Authentication.

With this release, we are adding Mobile functionality to OpenShift in the following ways:
* A new Mobile Category in the OpenShift Service Catalog, where you can create Mobile Clients and Mobile Services
  ![](/img/catalog-mobile-clients.png)


* A new Mobile section in the Project Overview panel where you can manage your Mobile Clients and bind them to the available Mobile Services
  ![](/img/overview-mobile-clients.png)


* A suite of Mobile Services to provide out of the box solutions to common development challenges such as Authentication & Authorization, Push Notifications, Capturing Device Metrics, Device Security and Mobile Build Automation.
  ![](/img/catalog-mobile-services.png)


To get started with AeroGear Mobile Services, the first step is to register a Mobile Client. Mobile Clients in OpenShift allow you to perform Cloud Native Mobile App Development using OpenShift as the back end for your mobile apps. A Mobile Client is a representation of the mobile app that you are developing locally. Mobile Clients allow you bind your local mobile app to mobile services such as Identity Management, Push Notifications, Mobile Metrics and others. This makes many of the common tasks associated with mobile development much easier and quicker to implement.

![](/img/mobile-clients-services.png)


We're really excited about what we've been building, and would encourage you to [get started](/getting-started/) with AeroGear today.

\- *The AeroGear Team*

## FAQs

### Where is the old aerogear.org site?

We will shortly be adding a link to get back to the old site. Until then, you can browse the source of the site [here](https://github.com/aerogear/aerogear.org/tree/old-site).

### Can I still use Unified Push outside of OpenShift?

Yes, the existing release of [Unified Push](https://github.com/aerogear/aerogear-unifiedpush-server/releases/tag/2.1.0.Final) is still available for use. However, moving forward we will be focusing on deploying and running the AeroGear Services on OpenShift. We encourage you to take a look at our new Mobile Services and experience the value of running Mobile Services on OpenShift.

### What about FeedHenry?

The [FeedHenry project](http://feedhenry.org) is the upstream for our current RHMAP product. AeroGear Services is a different project which looks at Mobile development use-cases embedded within OpenShift. The efforts of both communities will separate at this point.
