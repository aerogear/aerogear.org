---
layout: basic
title: AeroGear Client Paging

---

# Client Paging

This document describes the client side interfaces which a developer can use to Page through data obtained from remote rest services.  This document describes both how to interact with paging enabled applications as well how to extend the client libraries and APIs to support most other restful services.

At a high level, Paging is supported through the Pipe's `read` method (see the platform API doc, for specific details).

## Set up the Paging

In order to start a paging request, the API needs to accept a configuration setting, which sets the offset of the first element that should be included in the returned collection (`offset`) and the number of results that should be listed on a page (`limit`). The different platform SDKs may support different ways to apply the _paging configuration_ (see the platform API doc, for specific details).

The actual Pipe implementation will be responsible for processing a request along with any paging data and sending the appropriate headers, data, and query parameters to the server application.  Once the response has been received, the Pipe implementation will provide the result to the supplied callback (see the platform API doc, for specific details).


***

## The Paging configuration

An object to apply general information about a (paging) request.

### Properties

#### Pipe level

*locations*

- _metadataLocation_: String, indicates whether paging information (see `identifiers`) is received from the response `header`, the response body (`body`) or via [RFC 5988](http://tools.ietf.org/html/rfc5988) (`webLinking`), which is the `default`.

*Linking*

- _nextIdentifier_: String, the `next` identifier name (default: `next`) 
- _previousIdentifier_: String, the `previous` identifier name (default: `previous`) 


#### Request- and Pipe- level

The _paging parameters_ can be defined on the Pipe and on the _paging request_. For instance an initial default (e.g. list always 15 items per page and always start at the second page) works fine on the Pipe. The Pipe is responsible to maintain the paging requests (e.g. `next` or `previous`), by using the given `identifier`s.

However, it should be always possible for a user to update the arguments on a _per request_ base. For instance if the application needs to show for a specific reason `20` items _instead_ of the 15 from the beginning. Another reason could be the server does _not_ support the above discussed `identifier`s, so the application developer needs to maintain the _next_ and _previous_ information.

##### DEFAULT parameter providers

*offset*

- _offsetValue_: String, the offset of the first element that should be included in the returned collection (default: `0`)

*limit* 

- _limitValue_: int, the maximum number of results the server should return (default: `10`)

##### CUSTOM parameter providers

A `parameter provider` API will be provided to that the application developer can submit any (paging) parameter that the used server requires. An example would be that the used paging service supports sorting as well. 

***

### The Pagination - Scrolling through the result set

In order to navigate through a large data set, the following methods are required. The actual implementation can be different, based on the used SDK (see the platform API doc, for specific details).

### Methods
- _next_: Reads the next 'page' of the paging result, from the server.
- _previous_: Reads the previous 'page' of the paging result, from the server.

_NOTE:_ When scrolling outside of the allowed range (e.g. invoking `next` on the last page), the client should be able to handle any success response, whether there is data or not, and also any error response.

***

## Use cases - Behaviour 

### start the pagination and next

* start a `paged read` (see concrete API docs for details)
 * this returns the first page
 * scroll to the `next` or `last` page - if possible/desired 

### Jump to a specific page

* set up the paging configuration (set the `offset` to the desired page, e.g `offset:3`)
* issue a `read`
 * This returns the desired page
 * For there you can scroll (`next` or `previous`, if possible...)

