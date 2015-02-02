---
layout: basic
title: AeroGear Data Sync Java Client
---

# Status: Experimental

# Java Client API specification

### SyncClientEngine
The [SyncClientEngine](https://github.com/danbev/aerogear-sync-server/blob/refactoring-squashed/client/client-core/src/main/java/org/jboss/aerogear/sync/client/ClientSyncEngine.java) is 
responsible for driving the main differential synchronization algorithm but leaves the details of how data is stored and how diffs/patches are processed on that data to injectable 
implementations.
It does this by getting injected during [construction](https://github.com/danbev/aerogear-sync-server/blob/refactoring-squashed/client/client-core/src/main/java/org/jboss/aerogear/sync/client/ClientSyncEngine.java#L46) with an instance of a _ClientSynchronizer_ and a _ClientDataStore_. 

### ClientDataStore
The [ClientDataStore](https://github.com/danbev/aerogear-sync-server/blob/refactoring-squashed/api/src/main/java/org/jboss/aerogear/sync/client/ClientDataStore.java) defines the methods for
storing a specific document types.

### ClientSynchronizer
The [ClientSynchronizer](https://github.com/danbev/aerogear-sync-server/blob/refactoring-squashed/api/src/main/java/org/jboss/aerogear/sync/client/ClientSynchronizer.java) defines the methods
required to perform the specific diff/patch processing on the data type supported.

#### Example of constructing a ClientEngine
To construct a server that uses the JSON Patch [synchronizer](https://github.com/danbev/aerogear-sync-server/tree/refactoring-squashed/synchronizers/json-patch) you would use the following code:

    JsonPatchClientSynchronizer synchronizer = new JsonPatchClientSynchronizer();
    ClientInMemoryDataStore<JsonNode, JsonPatchEdit> dataStore = new ClientInMemoryDataStore<JsonNode, JsonPatchEdit>();
    ClientSyncEngine<JsonNode, JsonPatchEdit> clientSyncEngine = new ClientSyncEngine<JsonNode, JsonPatchEdit>(synchronizer, dataStore);

### Synchronizers
A _synchronizer_ in AeroGear is a module that serves two purposes which are closely related.  
One, is to provide storage for the data type, and the second is to provide the patching algorithm to be used on that data type. 
The name _synchronizer_ is because they take care of the synchronization part of the Differential Synchronization algorithm

For example, one synchronizer might support plain text while another supports JSON Objects as the content of documents being stored. But a patching algorithm used for plain text might
not be appropriate for JSON Objects. Hence the server and client side components are made up of "pluggable" [synchronizers](https://github.com/danbev/aerogear-sync-server/tree/refactoring-squashed/synchronizers) and data stores implementations.

By implementing the _ClientDataStore_ and _ClientSynchronizer_ interfaces different data formats and diff/patching algoritms can be provided. The AeroGear project provides the following 
[synchronizers](https://github.com/danbev/aerogear-sync-server/tree/refactoring-squashed/synchronizers/json-patch) out of the box:  

*  [DiffMatchPatch](https://github.com/danbev/aerogear-sync-server/tree/refactoring-squashed/synchronizers/diffmatchpatch)   
This synchronizer uses plain strings the document data type and Neil Frasers DiffMatchPatch Java implementation 
for its patching algorithm.  

*  [JSON Patch](https://github.com/danbev/aerogear-sync-server/tree/refactoring-squashed/synchronizers/json-patch)   
This synchronizer uses [Jackson's](http://wiki.fasterxml.com/JacksonHome) _JsonNode_ as the document data type and uses 
[JSON PATCH](https://tools.ietf.org/html/rfc6902) for its patching algorithm.


