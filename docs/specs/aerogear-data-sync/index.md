---
layout: post
section: docs
title: AeroGear Data Sync
---

<span class="label label-warning">Status: Experimental</span>

## References

- [Jira](https://issues.jboss.org/browse/AGSYNC-7)

## Features

* Detect Change

    When a user changes her local data, the system should note the change and generate a sync message to send to the server.  This can be done automatically or manually, but SHOULD be done automatically.

* Send update

     When a sync message is ready to be sent, and the system allows for it to be sent (network available) then sync message should be sent. This being done automatically should be the default, but the developer can override this behavior.

* Receive Update

    When a client updates its data and successfully syncs to the remote server, the remote server will notify all of the relevant clients. The client must automatically and without user intervention receive this update and either act on it or store it for later processing.

* Apply Update

    Once a client application has an update message from the server, it can apply the message to correctly update its local data.  This should be done automatically as part of receiving the update, but it may be done manually or may be delayed and automatically executed later.

## Read More

* [Message Format](../aerogear-sync-data-format)
* [AeroGear Java Server API](../aerogear-sync-server-java-api/org/jboss/aerogear/sync/server/ServerSyncEngine.html)
* [AeroGear Java Client API](../aerogear-sync-server-java-api/org/jboss/aerogear/sync/client/ClientSyncEngine.html)