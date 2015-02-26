---
layout: post
section: news
title: AeroGear iOS SDK v2.1 is out !
author: corinnekrych
module: core
---


Hi AeroGear community,

we are happy to announce the next versions of our iOS [Swift](https://developer.apple.com/swift/) libraries. Here are few of new features introduced in each respective lib:

- [aerogear-ios-jsonsz](https://github.com/aerogear/aerogear-ios-jsonsz) *(new)*

	A newly introduced library which will take care the cumbersome plumbing required when performing JSON serialization back and forth from your Swift object model. Check out the [documentation](https://aerogear.org/docs/guides/aerogear-ios-2.X/JsonSZ/) for an overview as well as our [Buddies cookbook](https://github.com/aerogear/aerogear-ios-cookbook/tree/0.2.0/Buddies) for example usage.
	
- [aerogear-ios-http](https://github.com/aerogear/aerogear-ios-http)

	We added the ability to perform basic/digest authentication when performing REST requests. Check out the [HTTP Basic/Digest authentication support](https://aerogear.org/docs/guides/aerogear-ios-2.X/HttpLib/#_http_basic_digest_authentication_support) section in our [library documentation](https://aerogear.org/docs/guides/aerogear-ios-2.X/HttpLib/) as well as our [Authentication cookbook](https://github.com/aerogear/aerogear-ios-cookbook/tree/0.2.0/Authentication) for an example usage. Remember to prefer HTTPS over plain HTTP when performing authentication of this type!

- [aerogear-ios-oauth2](https://github.com/aerogear/aerogear-ios-oauth2)

	Continuing the development of our OAuth2 library, OpenID Connect support was added to the library in the form of a _login_ request. Check out  the [Login using OpenID Connect](https://aerogear.org/docs/guides/aerogear-ios-2.X/Authorization/#_login_using_openid_connect) section in our [library documentation](https://aerogear.org/docs/guides/aerogear-ios-2.X/Authorization/) as well as our [SharedShoot cookbook](https://github.com/aerogear/aerogear-ios-cookbook/tree/0.2.0/SharedShoot) example that logins to [KeyCloak server](http://keycloak.jboss.org) using OpenID connect for an example usage. Further, [Corinne](https://twitter.com/corinnekrych) blog posts [here](http://corinnekrych.blogspot.com/2014/11/oauth2-for-android-and-ios-with-keycloak.html) and [here](http://corinnekrych.blogspot.com/2014/10/aerogear-with-keycloak-oauth2-friends.html) give more information regarding our OAuth2 implementation and is highly recommended if you are interested in the subject.

- [aerogear-ios-httpstub](https://github.com/aerogear/aerogear-ios-httpstub)

	Stubbed responses from the local file system can be used instead of coding them in your code. This will make easier to stub responses, especially big ones and be much ‘closer’ to the reality. Checkout out [Stubbed response loaded from a file](https://aerogear.org/docs/guides/aerogear-ios-2.X/HttpStub/#_stubbed_response_loaded_from_a_file) section in our  [library documentation](https://aerogear.org/docs/guides/aerogear-ios-2.X/HttpStub) for example usage as well as our [tests](https://github.com/aerogear/aerogear-ios-httpstub/blob/master/AeroGearHttpStubTests/AGURLSessionStubsTests.swift).


Last, this release introduces [Cocoapod](http://cocoapods.org) support for our libraries. Although Cocoapod hasn’t yet officially support ‘Swift’, that is planned for the next 0.36 release, a branch on the project is working on it and already looks solid enough with many Swift libraries starting to adopt. Just make sure to install the _'pre'_ release version of cocoapods (Check the [Cocoapods blog](http://blog.cocoapods.org/Pod-Authors-Guide-to-CocoaPods-Frameworks/) for more information).

#### What's next?
We are currently focusing most of our efforts on providing sync support. Already work [has been started](https://github.com/aerogear/aerogear-ios-sync) so expect more in-this front in the coming months. If you are interested in mobile-sync that is the perfect time to join us, we will be happy to know your thoughts and suggestions. Interesting things ahead of us..!

So, give the libraries and demos a spin and let us know what  you think!  If you run into any problems, please [file an issue](http://issues.jboss.org/browse/AGIOS)  and/or ask our [dev](https://lists.jboss.org/mailman/listinfo/aerogear-dev) and [user](https://lists.jboss.org/mailman/listinfo/aerogear-users) mailing list or join us on IRC  [#aerogear channel](irc://irc.freenode.net/aerogear)

Have fun!

AeroGear iOS team