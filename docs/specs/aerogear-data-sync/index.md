---
layout: basic
title: AeroGear Data Sync
---
# Status: Experimental

# References

- [Jira](https://issues.jboss.org/browse/AEROGEAR-1374)
- [CouchDB data model](http://wiki.apache.org/couchdb/EntityRelationship)

# Features

* Detect Change

    When a user changes her local data, the system should note the change and generate a sync message to send to the server.  This can be done automatically or manually but SHOULD be done automatically.

* Send update

     When a sync message is ready to be sent, and the system allows for it to be sent (network available, not in blackout window from exponential backoff, etc) then sync message should be sent. This being done automatically should be the default, but the developer can override this behavior.

* Receive Update

    When a client updates its data and successfully syncs to the remote server, the remote server will notify all of the relevant clients. The client must automatically and without user intervention receive this update and either act on it or store it for later processing.

* Apply Update

    Once a client application has an update message from the server, it can apply the message correctly to the data on it.  This should be done automatically as part of receiving the update, but it may be done manually or may be delayed and automatically executed later.

* Detect Conflict

    When applying an update fails, the system must detect this.  The system will provide state to the application and/or the user to handle the conflict.  The user MUST NOT have to check for conflicts on her own.

* Resolve Conflict

    There must be a mechanism for resolving a conflict.  The CAN be done automatically using default resolvers provided by AeroGear, by using a resolver provided by the developer/user, or by the app user selecting the correct merge.  This will possibly generate a new sync message.


# Scenarios

| Use Case      | Push/Poll 	| Realtime 	| Server | APIs Used 
| ------------- |:-----------:| --:| ---------:| -------:|
| Periodic Read Only Update | Poll | N | Any legacy | Pipelines, Authentication, Stores 
| Real Time Read Only Update | Push | Y(ish) | Legacy + Updates for Unified Push | Unified Push, Store 
| Simple Settings Sync | Push | Y(ish) | Legacy + Updates for Unified Push + Updates for conflict mgmt | Pipelines, Authentication, UnifiedPush, Store
| Real Time Text Sync | Push | Y | Needs lots of custom code, vert.x realtime component | UnifiedPush, Store 


# API specification

This document defines a common API for each mobile platform to make sure that everyone will be speaking about the same domain/vocabulary. 

## Sync strategies

We will have two synchronization strategies.  A document-revision strategy and a merge shadow strategy.  These strategies will be implemented by **[Repository](https://github.com/secondsun/aerogear-android-sync/blob/master/android/src/org/jboss/aerogear/android/sync/Repository.java)** classes. 

### Document-revision Strategy

The document revision startegey is based on maintaining relevant metadata abotu document revision and keeping it in lockstep with a server which fufills the stratgey contrcat.

#### Data model

This data model is defined in JavaScript Object Notation (JSON) and specifies the application protocol for AeroGear Data Sync.


| Name | Type        | Required    | Description
| ------------- |:-----------:|:-----------:|:-----------:|
| id            | String      | N           | Global identifier for the object |  
| rev           | String      | N           | Revision of the object. When a object gets updated the revision will be incremented  |  
| parent-rev    | String      | N           | Revision of the content which is edited.  It will be checked to make sure that the merge is conflict free.  |  
| content       | String      | Y           | This is the sync data for the application. It may be a diff, a whole object, etc.     |  

#### Transport

We will submit documents as JSON.  The server will respond with an appropriate error code and body in json format.  All communication is UTF-8 encoded.

#### Usage / Lifecycle

- [Google Drawing Example](https://docs.google.com/drawings/d/1E4NDEh3NQCdoEHNNHba4TR2akNrppvV5zDlk5nfzz08/edit)

The general usage flow is the use will create or edit content, attach the appropriate document metadata, and submit it to a server.  The content will be included in all of the requests and omitted from all responses except where otherwise noted.

 * New Data:  The id, rev, and parent rev fields will be empty strings.  The server will return 200 OK and the body will contain the document ID, document revsion, and an empty parent revision.  This will be saved on the client.
 * Edited Data, no Conflict:  The id field will be the cannoical id field form the server.  The rev field will be an empty string.  The parent-rev field will be the value of the rev field of the data before it was edited.  The server will return 200 OK and include the new revision value.  This will be saved on the clients side.
 * Edited data, with Conflict:  The request is the same as with an Edit, but the response from the server will be 409 Conflict with a body of the current server document.  It will be the clients responsibility to correct its Edited document and resubmit.
 * Updating local data:  The client may, at any time, fetch the document from the server and replace its content.
 * Receiving notification of updates from the server:  TBD

### Merge Shadow strategy

The Merge shadow strategy does not use document metadata to manage state.  Instead it generates diffs between edited and synced data and submits those to its peers semi regularly.

 * See [diff-merge-patch algorithm](http://code.google.com/p/google-diff-match-patch/)

#### Data model

 - TBD 
 
#### Transport

 - TBD
 
#### Usage / Lifecycle

 - TBD

## DataSyncronizer

The **DataSynchronizer** is responsible for contacting a remote store, pulling updates, passing remote updates to the local **Repository**, and sending local updates to the remote store.

### Usage

 * `read : *objectID*, *callback*` : this method will fetch from a remote store the object with the given objectID.  If the read is successful, the synchronizer will attempt to update the local **Repository** for the object.  It will then pass the object to the *callback* success method.
 
 * `save : *objectContent*, *callback*` : this method will save the local *data* to a remote store.  This method will be responsible for handling recoverable errors and updating local data if necessary.  In the case of a diff-merge-path style syncronization strategy, an unsuccessful POST could return a diff which, if sucessfully applied, would allow for a successful POST.  In this case, the save would be retried and *callback*'s success method would be called.
 
### Notes
This is based on lohlmquist's [poc](https://github.com/lholmquist/ag-js-ds-poc/blob/master/aerogear.custom.js)

# Implementation reference

- [Client API Proposals](../aerogear-sync-client-api)
- [Server API Proposals](../aerogear-sync-server-api)

# AeroGear Data Sync 0.0.1

- [AEROGEAR-1462](https://issues.jboss.org/browse/AEROGEAR-1462) - Send/Receive Updates

# AeroGear.next

- Realtime data sync
- Update policies
- Advanced levels of the API
    - level 3: real-time updates via diff-match-patch
    - level 4: real-time updates via OT/EC

## Reference (Open Source) Products:

- Wave-in-a-box

- CouchDB

- Google Drive RealtimeAPI

- [diff-merge-patch algorithm](http://code.google.com/p/google-diff-match-patch/)

- [Summers' Realtime Sync Demo](http://www.youtube.com/watch?v=WEkZGbVk4Lc)

- [Summers' Devnexus Sync Demo](https://plus.google.com/103442292643366117394/posts/HGVHwtPArPW)

- Google Android Sync Architecture


# Questions for consideration:

How will save/delete work?
How will readWithFilter work?
What happens if we have stale data and no internet connection?
Should we include a job which fetches data in the background instead of checking when the call is made?


# Appendix Use Cases:

Here are a few contrived use cases that we may want to keep in mind.

1.  Legacy Bug Trackers From Hell

    a.  It is a webapp written in COBOL, no one will ever EVER update or 
change the code

      b.  It has TONS of legacy but important data

      c.  It has TONS of users

      d.  It only has a few transactions per day, all creating and updating 
bug reports

      e. Multiple users can edit the same report


2.  Slacker Gallery

      a.  Each User has a multiple galleries, each gallery has multiple photos

      b.  A Gallery has only one user, but the user may be on multiple devices

      c.  Galleries may be renamed, created, and deleted

      d.  Photos may only be created or deleted.  Photos also have meta data 
which may be updated, but its creation and deletion is tied to the Photo 
object.


3.  Dropbox clone

      a.  A folder of files may be shared among users

      b.  There is a size limit to files and how much storage may be used 
per folder

      c.  Files are not updated.  If there is a new file, there is an atomic 
delete and create operation


4.  Email client

       a.  This is an AG-controller which accesses a mail account.

       b.  There are mobile offline and sync enabled clients which connect 
to this controller.


5.  Google Docs clone

       a. Operational Transform out the wazzoo

       b.  What would the server need?

       c.  What would the client need?


6.  Building Inspector app

Building inspector system - we have mobile apps that store relevant info and are bound to be accessed on places where we won't have any kind of connection, or very poor signal.

You can have several inspectors screening the same building simultaneously.

Let's say we have Agnes and Joe are doing the fire extinguisher inspection in a new hospital building. Technically each fire extinguisher has its own identifier and can be an independent document. In this case we would have no conflict happening.

Now they start finding expired fire extinguishers and start to add them to the report. This report could potentially have two divergent lists of fire extinguishers to be replenished/revalidated, as the building's compliance status.

7. Census App

Census system - we have mobile apps focused on offline data collection. We have the previous year's info that needs to be updated on the server. The interviewee needs to take a call, then asks the interviewer to come back later. This results in two sets of changes for the same document, stacked together, which should work flawlessly.




