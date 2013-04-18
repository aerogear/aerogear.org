---
layout: basic
title: AeroGear Client Content Pipes 

---

# AeroGear Pipelines and Pipes

The Aerogear client libraries provide the **Pipe** interface as an abstraction around high latency data sources.  **Pipe** defines several asynchronous methods for performing CRUD operations on a `resource` managed by this source.

**Pipe** objects are instanciated, referenced, and accessed from the **Pipeline** service.  **Pipeline** consumes a `baseURL`, and a **PipeConfig** object to create a **Pipe**.  

## Pipe 

### Behavior & Functions

**Pipe** instances should be threadsafe.  Calls to CRUD methods should not change the internal state of a **Pipe**.  These methods will not block and all consume a **Callback** parameter.  All of these methods will call `Callback.onFailure` in the event of an error.

Pipes are also responsible for applying any necessary metadata connected to a request including but not limited to authentication, authorization, and paging.  A Pipe is responsible for handling errors and passing them to the user.  

read(callback)
 : The will schedule an operation which will fetch a resource or collection and return this to `Callback.onSuccess`.

read(parameters, callback)
 : as `read(callback)` but this method also includes extra parameteres for reading.  These may be *identifiers*, *filtering*, or *paging parameters*(TODO link to paging param doc).

save(resource, callback)
 : This method will schedule an operation to persist the provided *resource*.  If successful, the resource will be passed to `callback.onSuccess`.

delete( id, callback )
 : This method will delete a resource with identified by *id*.  If successful `callback.onSuccess` will be called with no parameter.

**Pipe** implementations are allowed to delegate to or proxy objects which perform lower level operations such as file reads, socket connections, etc.  If this is the case, a **Pipe** object should expose this object as a *Handler* property.

### Configuration

**Pipe** instances have the following properties which will be consumed by **Pipeline** to create instances.

resource
 : This is a type of object or data that the **Pipe** interacts with.  I.E. a blog has resources post, author, comment, etc

baseURL
 : This is the URL of the service which is hosting resources a **Pipe** handles
    
name
 : this is value that **Pipeline** will use to reference a **Pipe** instance.  It defaults to `lowerCase(resource)`
    
endpoint
 : This is the value appended to baseURL to form the full URL to `resource`.   It defaults to `lowerCase(resource)`
    
type
 : This is the implementation of the **Pipe** instance.  It defaults to `REST`.

pageConfig
 : This is the configuration for paging.  (//TODO link to paging)

authModule
 : This is the object which will provide authentication information.  (//TODO link to a nd write authentication spec)

handler
 : This is a optional parameter which implements concrete operations such as file IO, network IO etc.

timeout 
 : This is the maximum time an operation is allowed to run.  When this limit is reached, `callback.onFailure` must be called.  It defaults to `MAX_INTEGER`.
 

### RestAdapter

**RestAdapter** is a implementation of **Pipe** provided by AeroGear which is used for accessing remote HTTP based REST services.

#### Method implementation details

read(callback)
 : HTTP_GET ${baseUrl}/${resource}

read(parameters, callback)
 : HTTP_GET ${baseUrl}/${resource}/${parameters.uri}?${parameteres.query} //TODO: Add in nested resources

save(resource, callback)
 : if resource has an `id` field HTTP_POST ${baseUrl}/${resource}/${id} with a JSON serialized body version of `resource`.  Otherwise HTTP_PUT ${baseUrl}/${resource} with the JSON serialized `resource`.

delete( id, callback )
 : HTTP_DELETE ${baseUrl}/${resource}/${id}

## Pipeline

A Pipeline is both a factory  for new **Pipes** and a reference to existing **Pipes**.

### Properties

baseURL
: the URL of the server the resources the *Pipes* will connect to

### Functions

pipe(PipeConfig)
: Creates a Pipe and stores a reference using the`name` property of the **PipeConfig**

get(pipeName)
: Returns a pipe associated with `pipeName`.  This is not guranteed to be the same instance.

get(pipeName, properties)
: Returns a proxy to the pipe associated with `pipeName`.  This instance will have extra behvaior based on `properties`.  For example in Android this method is used to build [Loaders](http://developer.android.com/guide/components/loaders.html) used by the **Pipe**.  The values accepted by this method are platform specific.

remove(pipeName)
: Removes a pipe associate with `pipeName`

