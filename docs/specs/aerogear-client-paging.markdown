--- 
layout: basic
title: AeroGear Client Paging Spec
---
## Client Paging

This document describes the client side interfaces which a developer can use to Query and Page through data obtained from remote rest services.  This document describes both how to interact with the Aerogear-Controller based paging as well how to extend the libraries and APIs to support most other restful services.

At a high level, Paging and Querying is supported though the Pipe.readWithFilter(Query, Callback) method.  A Query object will set the current page, number of results perPage, and a where property.  The Pipe implementation will be responsible for processing a request along with any paging data and sending the appropriate headers, data, and query parameters to the server.  Once the response has been received, the Pipe implementation will provide a List of objects to the supplied callback.  If this call used paging, the List will be an instance of PagedList.

PagedList will be a List<T> of results for the request, but also have methods for retrieving the next list.

***

### The Query Class

Query is a value object to store general filter information about a request.  It has a convenience method to generate a query.

#### Properties
*offset*:int the requested page index

*limit*:int the maximum number of results the server should return

*where*:Dictionary a Dictionary representing the where clause.  In general this will be a collection of key/value pairs; however, nested queries CAN be supported.

***

### The PagedList Interface

PagedList extends List.

#### Methods

**next**(*callback*):void Async Method to call the filter selected by *nextFilter*. A new PagedList instance will be passed to *callback* as per Pipe.readWithFilter.

**prev**(*callback*):void Async Method to call the filter selected by *prevFilter*. A new PagedList instance will be passed to *callback* as per Pipe.readWithFilter.

**hasNext**():boolean returns true if there is a nextFilter set

**hasPrev**():boolean returns true if there is a prevFilter set


***

### PipeConfig values relating to Paging

**metaDataLocation**:Enum with values header or content.  This property represents WHERE the paging data is.

**nextField**:String the key value that the server will send back which represents next page of data

**prevField**:String the key value that the server will send back which represents previous page of data

**toalField**:String the key value that the server will send back which represents the total number of pages
