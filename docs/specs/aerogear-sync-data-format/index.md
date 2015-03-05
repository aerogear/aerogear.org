---
layout: post
title: AeroGear Sync Data model
---
# Status: Experimental

# Message format
This section defines the message format that is sent between a client and a server.

## Add message type
The _add_ message is sent when a client wants to add a document/object into the server sync engine.
The format is in Java Object Notation (JSON) and has the following structure:

    { "msgType": "add",
      "id":"12345",
      "clientId":"76170b10-5d2f-496f-b4ba-c71b31a27f72",
      "content":{"name":"Luke Skywalker"}
    }

*msgType*
The typeof this message. Must be ```add```.

*id*
The document identifier for this document being added. This value is chosen by the client and all clients that use the same document id receive updates when this
document is updated.

*clientId*
An identifier for the client adding the document. This value must be a unique identifier for the client.

*content*
The actual content of the document/object being added. The type of content depends upon the type of documents the server supports.
In the above example the document/object content type is JSON.

## Patch message type
The _patch_ message is sent when a client or server has updates that need to be sent the the other side.
The format is in JSON and has the following structure:

    { "msgType": "patch",
      "id": "12345",
      "clientId":"76170b10-5d2f-496f-b4ba-c71b31a27f72",
      "edits":[
        { "clientVersion":0,
          "serverVersion":0,
          "checksum": "da39a3ee5e6b4b0d3255bfef95601890afd80709",
          "diffs": [
            { "op":"replace","path":"/name","value":"Darth Vader" }
          ]
        }
      ]
    }

*msgType*
The typeof this message. Must be ```patch```.

*id*
The document identifier for this document being updated.

*clientId*
An identifier for the client.

*edits*
Is an array of updates. An edit is created for each diff taken on the client or server side. These edits are stored before sending to the opposing side, and
removed after being applied. They act as acknowledgments.

*clientVersion*
This is client version that this edit was based on.

*serverVersion*
This is server version that this edit was based on.

*checksum*
This is checksum for the shadow document on the opposing side.

*diffs*
The format of diffs depends on the type of document/object type that the server supports. In the above example the format of patches is of
[JSON PATCH](https://tools.ietf.org/html/rfc6902).


