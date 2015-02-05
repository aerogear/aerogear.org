---
layout: post
title: OAuth2 support on AeroGear
---

Fasten your seatbelts, because today we are pleased to announce the official availability of our SDKs for OAuth2.

# So what!?

We all know that security can be tricky sometimes, due to numerous misunderstandings and subtle details behind it. For this reason, since last year our team has been working hard on putting together the [RFC 6749](https://tools.ietf.org/html/rfc6749), [RFC 6750](https://tools.ietf.org/html/rfc6750) and [OpenID Connect protocol](http://openid.net/connect/) on Android, iOS and Cordova.

Just to give you a general idea, the table below reflects the current state of our APIS:

| Flows          | Android | iOS | JavaScript | Cordova | Windows Phone |
|:---------------------:|:-------:|:---:|:----------:|:-------:|:-------------:|
|[Implicit grant flow](https://tools.ietf.org/html/rfc6749#section-4.2)|&#10004;|&#10004;|**-**|_soon_|&#10004;|
|[Refresh access tokens](https://tools.ietf.org/html/rfc6749#section-4.3)|&#10004;|&#10004;|**-**|**-**|**-**|
|[Token revocation](http://tools.ietf.org/html/rfc7009#section-2)|**-**|&#10004;|**-**|**-**|**-**|
|[Resource owner password credentials grant](https://tools.ietf.org/html/rfc6749#section-4.3) |**-**|_soon_|**-**|**-**|**-**|
|[Authorization Code Grant](https://tools.ietf.org/html/rfc6749#section-4.1)|&#10004;|&#10004;|**-**|**-**|**-**|

# Quickstarts

We have a demo application, called Shoot’n Share for all of our supported platforms (Android, iOS and Cordova). The application allows you to upload a photo to Facebook, Google+ or a [Keycloak](http://keycloak.jboss.org/) protected backend.

The different applications can be found it the platform specific cookbooks:

* [Android Shoot’n Share](https://github.com/aerogear/aerogear-android-cookbook/tree/master/ShootAndShare)
* [iOS Shoot’n Share](https://github.com/aerogear/aerogear-ios-cookbook/tree/master/Shoot)
* [Cordova Shoot’n Share](https://github.com/aerogear/aerogear-cordova-cookbook/tree/master/Shoot)

The application is a simple Java EE / JAX-RS based application, which is located [here](https://github.com/aerogear/aerogear-backend-cookbook/tree/master/Shoot).

## What's next?

We will have OAuth2 support on Windows Phone very soon, as well keep improving our current libraries. If you want to take an early look, clone the [repository](https://github.com/aerogear/aerogear-windows-oauth2) and give the [Shoot’n Share](https://github.com/aerogear/aerogear-windows-cookbook/blob/master/Shoot/README.md) app a try!

Don't hold your breath and try it. If you run into any issues, please ask on the [mailing list](https://lists.jboss.org/mailman/listinfo/aerogear-dev).

With love, AeroGear.
