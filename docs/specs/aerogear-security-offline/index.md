---
layout: basic
title: Offline Storage Specification (OSS)
---

# Status: Experimental

**Note**: This document is a working progress if you strongly disagree with something, feel free to discuss.

# Authors

- [Bruno Oliveira](http://blog.abstractj.org/contact/)
- Daniel Passos

# Goals

- Permit users to authenticate when the server is offline
- Encrypt the local storage and the temporary cached data to protect user's privacy

# Introduction

Offline storage is still a challenging subject for mobile development, because it is a wild environment where developers do not have any control over it, users can have their devices stolen, borrowed by someone or infected with whatever kind of malware available.  There is no magic, most part of the time you can just hope for the best and try to conciliate security and usability instead of put them under glass.

The [previous release](https://issues.jboss.org/browse/AGSEC-156?jql=fixVersion%20%3D%20%221.3.0%22%20AND%20project%20%3D%20AGSEC) our major concern was to lay the groundwork for future growth. This documentation will discuss: offline authentication, encrypted cache, how to protect the local storage and some possibilities for data sync.

## Offline Authentication
 
Server-side authentication is easy compared to offline, because we don't need to worry about how the password will be kept on the server. When the device goes offline one critical problem will emerge: users will lost their access to the application.

On the bright side the solution is simple at first glance, the application requests users to enter their credentials at the first time the application is started,  but the password **can't** be kept on device, because that would represent a risk if device is stolen, lost, borrowed or infected with malware. The proposed solution is to make use of cryptographic functions in an attempt to slow down an adversary in case of the user's device is compromised.

![](http://photon.abstractj.org/offline_authentication.jpg_20140207_120553.jpg)
 
 A detailed explanation about the workflow:
 
1. Application requires username/password 
2. User provide the password registered into the application 
3. Application run *KDF* function over the credentials provided and pass as parameter to *KeyStore/KeyChain*
4. *KeyStore/KeyChain* validates that credential provided
5. Application retrieve the private key from the *KeyStore/KeyChain* if credentials are valid, otherwise display an error message
6. Once the private key was retrieved we are able to encrypt the local storage

## Encrypted Storage

The API should allow the local storage to be self-encrypted, by that we mean once **KeyStore/KeyChain** is opened, any data inserted was supposed to be properly encrypted.

### Remote storage

If the data must be kept in another infrastructure, the server should never have access to user's data, instead, the application should send the data encrypted as well the public keys for data sync. Once some data is added on the server side, it should be encrypted with the public key provided and sent back to the client.

**Note:** To not lose our focus here, *offline storage*, anything related with *data sync* will be proposed in a separated document 

## Encrypted Cache

Sometimes we just need to make use of caching mechanism for the temporally storage of some information like documents, images or presentations which doesn't mean they are not significant or critical, we never know what type of file will be there. 

Into this iteration we chose [LRU (*Least Recently Used*)](http://en.wikipedia.org/wiki/Cache_algorithms#Least_Recently_Used) as our caching mechanisms based on the state of data that have been used recently, in other words, if the data have not been used for decades it will probably remain unused for a long time. 

The approach for encrypting cache must be very similar to the local storage.

# API symmetry

## Android

The Android platform make use of [AeroGear Crypto](https://github.com/aerogear/aerogear-crypto-java) plus the [support added for the KeyStore management](https://github.com/aerogear/aerogear-android/blob/247009a1a729952bae964e34551c7cb92846a132/src/org/jboss/aerogear/android/impl/security/PasswordEncryptionServices.java#L74)  AeroGear Android providing an easy to use functionality to extract the private and public key.

    KeyManager keyManager = new KeyManager();
    PasswordProtectedKeystoreCryptoConfig keystoreCryptoConfig = new PasswordProtectedKeystoreCryptoConfig();
    keystoreCryptoConfig.setAlias("offline");

    //Derive the password with a KDF function
    keystoreCryptoConfig.setPassword(password.getText().toString());
    try {
          EncryptionService encryptionService = keyManager.encryptionService("key", keystoreCryptoConfig,
                LoginActivity.this);
            startActivity(new Intent(LoginActivity.this, DocumentsActivity.class));
    } catch (RuntimeException e) {
            Toast.makeText(LoginActivity.this, e.getMessage(), Toast.LENGTH_LONG).show();
    }
                
For caching functionalities, the plan is to provide [LruCache](http://developer.android.com/reference/android/support/v4/util/LruCache.html) as alternative.

## JavaScript

- It must be discussed, about how the encrypted cache should work in scenarios where passwords are not provided.
TBD

## iOS

The iOS platform will make use of [AeroGear Crypto iOS](https://github.com/aerogear/aerogear-crypto-ios) library for the generation of public/private keys and encryption. Further, since the keychain in iOS can be compromised, the key pairs generated would be further encrypted using the key generated by the KDF passphrase and stored using an appropriate protection class (_kSecAttrAccessibleWhenUnlockedThisDeviceOnly_).    


	AGKeyManager *keyManager = [AGKeyManager manager];
	
	AGPasswordProtectedKeychainCryptoConfig *keychainCryptoConfig = [[AGPasswordProtectedKeychainCryptoConfig alloc] init];
    [keychainCryptoConfig setAlias:@"offline"];
	
    //Derive the password with a KDF function
    [keychainCryptoConfig setPassword:password.text];
    
     // initialize the encryption service passing the config
    id<AGEncryptionService> encryptionService = [keyManager encryptionService:keychainCryptoConfig];

For caching functionalities, research the feasibility of using [NSCache](https://github.com/gnustep/gnustep-base/blob/master/Source/NSCache.m#L195)
 

# Demo application

- https://github.com/danielpassos/aerogear-offline-android-demo/

# Planned Jiras

## Offline Storage
component: offline, crypto, storage

- AGSEC-XXX: Queries on encrypted database

*Description*: Currently for the local storage we encrypt and decrypt the whole database, which makes the solution impractical in scenarios where 1GB of data is provided

- AGSEC-XXX: Key management based on device unlock

*Description*: Investigate if is possible to derive the key based on device unlock or PIN

## Encrypted Cache
component: offline, crypto, cache

- AGSEC-XXX: R&D about LRU

*Description*: Currently is necessary to investigate better if LRU is the best politic for JS, iOS and Android for the sake of API symmetry

- AGSEC-XXX: Add data caching support for mobile devices

*Description*: Allow developers to choose when they want to cache the data

* AGSEC-XXX: Add cache encryption support for mobile devices

*Description*: Allow developers to choose when they want their cache encrypted

## Remote Storage
component: crypto, sync

- AGSEC-XXX: Device registration

*Description*: Device registration and management on the server side

- AGSEC-XXX: Revoke capability

*Description*: Adds the ability to revoke the key stored on device using another authorized device 

- AGSEC-XXX: Remote wipe a mobile device

*Description*: Removal of the data when the user is online including offline storage and cache

- AGSEC-XXX: Add Public Key to Remote Server

*Description*: Send the public key to the server. The key provided will be used to encrypt data and verify digital signatures. Ex. Thinking about data sync when user include a record the server should be able to encrypt the data with the user's public key and sent it back to the device.

- AGSEC-XXX: Public key authentication

*Description*: As an additional level of security each user will have her own digital signature to provide authentication and data integrity, ensuring that the origin is legit. Pretty similar to the SSH scheme, but we want to keep the password into this situation.

# Next steps

- This document is something completely under development, but before we move forward would be nice some feedback to guarantee that everyone is on the same page.
- File Jiras
- Implement it :)
