# OAuth2 support on AeroGear

Fasten your seatbelts, because today we are delighted to announce the official availability of our SDKs for OAuth2.

# So what!?

We all know that security can be tricky sometimes, due to several misunderstandings and subtle details behind it. For this reason, since last year our team has been working hard putting together the [RFC 6749](https://tools.ietf.org/html/rfc6749), [RFC 6750](https://tools.ietf.org/html/rfc6750) and [OpenID Connect protocol](http://openid.net/connect/) on Android, iOS and Cordova.

Just to give you a general idea, the table below reflects the current state of our APIS:

| Flows          | Android | iOS | JavaScript | Cordova | Windows Phone |
|:---------------------:|:-------:|:---:|:----------:|:-------:|:-------------:|
|[Implicit grant flow](https://tools.ietf.org/html/rfc6749#section-4.2)|n/a|n/a|:heavy_check_mark:|:soon:|n/a|
|[Refresh access tokens](https://tools.ietf.org/html/rfc6749#section-4.3)|:heavy_check_mark:|:heavy_check_mark:|:heavy_minus_sign:|:heavy_minus_sign:|:heavy_minus_sign:|
|[Token revocation](http://tools.ietf.org/html/rfc7009#section-2)|:heavy_minus_sign:|:heavy_check_mark:|:heavy_minus_sign:|:heavy_minus_sign:|:heavy_minus_sign:|
|[Resource owner password credentials grant](https://tools.ietf.org/html/rfc6749#section-4.3) |:heavy_minus_sign:|:soon:|:heavy_minus_sign:|:heavy_minus_sign:|:heavy_minus_sign:|
|[Authorization Code Grant](https://tools.ietf.org/html/rfc6749#section-4.1)|:heavy_check_mark:|:heavy_check_mark:|:heavy_minus_sign:|:heavy_minus_sign:|:heavy_minus_sign:|

# Quickstarts

## What's next ?


