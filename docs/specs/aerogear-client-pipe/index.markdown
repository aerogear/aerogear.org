---
layout: basic
title: AeroGear Client Content Pipes 

---
# Configuring and using Pipes

This document describes how Pipes are configured to fetch data from remote stores.  It also describes the imagined standard lifecycle of `read` calls and how the application should interact with this library.

# Using the Pipes

To use a Pipe, a user will instanciate a **Pipeline** object with the `baseUrl` of the server hosting the resources **Pipes** will connect to.  The **Pipeline** will consume a **PipeConfig** which can be accessed using a `name` parameter.

-------

## Pipe

A Pipe is an abstraction around a resource accessed from a high latency data store, often a remote server.  Pipe methods which interact with this store are asynchronous and return an identifier mapped to a **PipeWorker**.

Pipes are also responsible for applying any necessary metadata connected to a request including but not limited to authentication, authorization, and paging.  A Pipe is responsible for handling errors and passing them to the user.  

Pipes should be instantiated and accessed through the **Pipeline** and configured using a **PipeConfig** object.

### Parameters

type
: the type of pipe this is (eg REST, CONTENT PROVIDER,  WEB SOCKET)

url
: the full url of the resource the Pipe accesses

### Functions

read()
: Starts a call to a server and returns the id of the **PipeWorker**

readwithFilter(Filter)
: Starts a call to a server and returns the id of the **PipeWorker**

save(T)
: Starts a call to a server and returns the id of the **PipeWorker**

delete(id)
: Starts a call to a server and returns the id of the **PipeWorker**

## PipeConfig

A PipeConfig wraps values necessary for configuring a Pipe.  It will create sane defaults based on an initial configuration that can be overridden before it is used to create a Pipe.

### Required Properties

baseURL
:  the root of the URL that a Pipe’s resource will reference.  (ex **https://redhat.com/rest/**pipeResource)

resourceFoo
: the class/type of the resource being referenced

### Derived Properties

name
: the name of the **Pipe** to be referenced by **Pipeline**.  Defaults to a stringified, lowercase *resourceFoo*

:endpoint
: the part of the Pipe url which isn’t the baseURL.  (ex https://redhat.com/rest/**pipeResource**)  Defaults to a stringified, *resourceFoo*

type
:  the connection type of the pipe.  Defaults to REST

### Optional Properties

pageConfig
: A **PageConfig** instance which defines paging [add link]

authModule
: An **AuthenticationModule**

## PipeWorker

A pipeworker is a background process which loads a remote resource and calls a listener when it is finished.

## Properties

listener
: This is called on several events `RequestComplete`, `RequestError` ...

id
: The id of the worker.  Used by a listener to filter responses, look up workers, etc

## Functions

cancel
: ends the current request.  Future events will not be fired.

isCompleted
: returns true if the request is complete, false if not.

## Pipeline

A Pipeline is both a factory  for new **Pipes** and a reference to existing **Pipes**.

## Properties

baseURL
: the URL of the server the resources the *Pipes* will connect to

## Functions

pipe(PipeConfig)
: Creates a Pipe and stores a reference using the`name`property of the **PipeConfig**

get(pipeName)
: Returns the pipe associated with `pipeName`

remove(pipeName)
: Removes a pipe associate with `pipeName`


