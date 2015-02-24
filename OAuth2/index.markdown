---
layout: basic
title: AeroGear OAuth2
---

# OAuth2 (under development)

Support of OAuth2 for [Keycloak](http://keycloak.jboss.org/), Google and Facebook on our Android, iOS, Windows and Cordova platforms.

| Flows          | Android | iOS | JavaScript | Cordova | Windows Phone |
|:---------------------:|:-------:|:---:|:----------:|:-------:|:-------------:|
|[Implicit grant flow](https://tools.ietf.org/html/rfc6749#section-4.2)|**-**|**-**|**-**|_soon_|**-**|
|[Refresh access tokens](https://tools.ietf.org/html/rfc6749#section-4.3)|&#10004;|&#10004;|**-**|&#10004;|&#10004;|
|[Token revocation](http://tools.ietf.org/html/rfc7009#section-2)|**-**|&#10004;|**-**|**-**|**-**|
|[Resource owner password credentials grant](https://tools.ietf.org/html/rfc6749#section-4.3) |**-**|_soon_|**-**|**-**|**-**|
|[Authorization Code Grant](https://tools.ietf.org/html/rfc6749#section-4.1)|&#10004;|&#10004;|**-**|&#10004;|&#10004;|

## Roadmap

The AeroGear OAuth2 effort started out of a POC and we are now moving towards a first release. 

[List of 1.0.0 JIRA tickets](https://issues.jboss.org/browse/AGSEC-180)

## Development

Below are the various GitHub repositories that are part of the OAuth2 feature in AeroGear.

### Android

The [AeroGear Android Authz](https://github.com/aerogear/aerogear-android-authz) will give developers the ability to integrate their Android application with RESTful services secured with OAuth2.

### iOS

On iOS we do have a Swift based OAuth2 client [library](https://github.com/aerogear/aerogear-ios-oauth2).

### Windows

For Windows we have a client library for OAuth2 on [Windows phone](https://github.com/aerogear/aerogear-windows-oauth2).

### Apache Cordova

Our [Apache Cordova plugin](https://github.com/aerogear/aerogear-oauth2-cordova) for OAuth2 supports the following platforms:

* Android
* iOS
* Windows

### See it in Action

To see it in action, watch the screencast below:

<p><center><iframe width="560" height="315" src="https://www.youtube.com/embed/nEqwncaOcu4" frameborder="0" allowfullscreen></iframe></center></p>

## Demo applications 

We have a demo application, called _Shoot'n Share_ for all of our supported platforms (Android, iOS, Windows and Cordova). The application allows you to upload a photo to Facebook, Google+ or a Keycloak protected backend.

The different applications can be found it the platform specific _cookbooks_:

* [Android Shoot'n Share](https://github.com/aerogear/aerogear-android-cookbook/tree/master/ShootAndShare)
* [iOS Shoot'n Share](https://github.com/aerogear/aerogear-ios-cookbook/tree/master/Shoot)
* [Windows Shoot'n Share](https://github.com/aerogear/aerogear-windows-cookbook/blob/master/Shoot/README.md)
* [Cordova Shoot'n Share](https://github.com/aerogear/aerogear-cordova-cookbook/tree/master/Shoot)

The Keycloak protected backend application is a simple Java EE / JAX-RS based application. The source is located [here](https://github.com/aerogear/aerogear-backend-cookbook/tree/master/Shoot).

## Get involved

If you are interested, feel free to fork the repositories and get your hands dirty. Also, feel free to reach out to us if you have any [questions](/community)!
