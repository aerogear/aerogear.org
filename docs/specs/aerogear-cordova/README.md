This descirbes the JavaScript client API for AeroGear Cordova Plugins.

## Push Plugin
- - -

There is a global variable named push exported by Cordova that one can use to register the device for receiving push notifications.

See the [Push API docs](Push.html) for more info.

## OTP (One Time Password) Plugin
- - -

The AeroGear.Totp namespace provides a way to create a one time password based on a shared secret that can be read via barcode scanner. This plugin depends on the barcode plugin that will automaticly get installed as well.

See the [AeroGear.Totp API docs](AeroGear.Totp.html) for more info.

## Crypto Plugin
- - -

The AeroGear.Crypto namespace provides a way to encrypt and decrypt data, there is also a JS version of this, but this version delegates to the native libraries for increased speed and security.

See the [AeroGear.Crypto API docs](AeroGear.Crypto.html) for more info.