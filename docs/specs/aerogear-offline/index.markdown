---
layout: post
section: docs
title: AeroGear Offline API proposal
---

<span class="label label-warning">Status: Experimental</span>

# Goals

1. To manage resources (assumed files) on the mobile devices which are retrieved from transitory sources (ie online, SD cards, etc).
2. To provide a way to secure, and expire offline resource. (ie encryption and TTL policies)

# API

## Implementation 

### Storage API
 * `get` : *URL* **url**, *Callback* **callback**   
This should check and see if a file related to the URL is available. 
     * If the file is locally stored, the file should be passed to the callback's success method. 
     * If the file is not it should be fetched, saved, and returned to the callback's success method.

 * `remove` : *URL* **url**, *Callback* **callback**   
This should remove a file related to **url**. 
     * If the file is not locally stored, onSuccess will still be called. 


### Offline Factory
* `getStorage` : *String* **name**  
This will retrieve a *Storage* instance which has previously been created.

* `registerConfigurationProvider` : *Class* **configurationClass**, *ConfigurationProvider* **provider**   
Registers a **provider** which will take handle configuration for **configurationClass** types.

* `config` : *String* **name**, *Class* **configurationClass**   
Returns a configuration object which will build a *Storage* instance and can be fetch from *Offline* using `getStorage` with the **name** parameter. 

## Configuration

 
### Configuration Options

**TBD**
