--- 
layout: basic 
title: AeroGear REST API 
---
# AeroGear Server Side Interfaces #
This document describes the server side interfaces for AeroGear and is intended to be a guide for users creating new RESTful 
server side applications as well as for client developers to know how to interact with RESTful applications (what request/responses will look like).

----

## Transport protocol ##
The APIs described in this document are based on [Hypertext Transfer Protocol, version 1.1](http://www.ietf.org/rfc/rfc2616.txt)
and _HTTPS_ is recommended. 

----

## Resources ##
A resource, or an endpoint, is identified by an URL which is referred to as the resource url.  
For example, if you might have a resource of cars:

```http://server:port/myapp/cars```

When requesting data from a resource you often want to specify the format of the returned data.  
This is accomplished by using a HTTP header named _Accept_:

```Accept: application/json```

### BaseURL ###
All AeroGear client libraries (JavaScript, Objective-C, and Android) have the concept of a base url when creating a pipeline. This base 
url is the path to your application running somewhere.   

For example, say you deploy a web application with a context path of _myapp_ to a web/application server. The base url is the would 
be the URL to the root of this web application: 

```http://server:port/myapp```

----

## Versioning ##
Depending on the application in question, you might want to version it. There are several approaches to versioning RESTful application and we will discuss a few alternative methods in this section.

#### Using separate URLs ####
This method separates two version of application by using different URLs to the resource.  
In this case you might have version 1 deployed with a context path of:

```http://server:port/myapp/v1```

And later deploy version 2 as:

```http://server:port/myapp/v2```

Configuring the context path is specific to your web/application server. For example, configuring a context path for AS7 you would add a WEB-INF/jboss-web.xml:

    <?xml version="1.0" encoding="UTF-8"?>
    <jboss-web>
      <context-root>myapp/v1</context-root>
    </jboss-web>

#### Using a Query parameter ####
This method specifies the version using a query path parameter, for example:

```http://server:port/myapp/cars/1?version=1```

#### Using the Mediatype ####
This method uses the HTTP _Accept_ and _Content-Type_ headers to handle versioning of data as well as describing data. A client uses the HTTP request header _Accept_ to specify the media type(s) that it accepts. Using this method one can specify both the type wanted and the version:

```Accept: application/vnd.myapp.cars+json; version=1.0```

Note that you can create your own MIME types using the vnd (vendor) prefix, which is what the example above is doing. When a client requests data from your service, they create an HTTP request and set the Accept header to the correct MIME type.

----

## HTTP Methods ##
This section describes the different HTTP methods and the expected return status and messages for successful and unsuccessful requests.

### HTTP GET Method ###
Example of reading a resource, in this case a car with a certain id:

```http://server:port/myapp/cars/1```

##### Success status code and returned body #####
* ```HTTP/1.1 200 OK```  
    The Body will contain the data in the requested format.


##### Failure status code and desciption #####
* ```HTTP/1.1 401 Unauthorized```  
    The request requires authentication.
* ```HTTP/1.1 404 Not Found```  
    The requested resouces does not exist.

### HTTP PUT Method ###
Example of a PUT request:

```http://server:port/myapp/cars/1```

##### Success status code and returned body #####
* ```HTTP/1.1 200 OK```  
    The Body will contain the data in the updated data.
* ```HTTP/1.1 201 Created```  
    The newly added data.

A reason for returning the data could be that the server needs to process the data, for example, it might need to generate an unique id or something like that. 

##### Failure status code and desciption #####
* ```HTTP/1.1 400 Bad Request```  
    The format of the client request was incorrect.
* ```HTTP/1.1 401 Unauthorized```  
    The request requires authentication.
* ```HTTP/1.1 409 Conflict```  
    The data passed-in conflicted with the stored.
* ```HTTP/1.1 415 Unsupported Media Type```  
    The requested media type is not supported.  
    
##### Headers #####
* ```Location```  
    URL to the resource.

### HTTP POST Method ###
Example of a POST request:

```http://server:port/myapp/cars/1```

##### Success status code and returned body #####
* ```HTTP/1.1 201 Created```  
    The newly added data.

##### Failure status code and desciption #####
* ```HTTP/1.1 400 Bad Request```  
    The format of the client request was incorrect.
* ```HTTP/1.1 401 Unauthorized```  
    The request requires authentication.
* ```HTTP/1.1 409 Conflict```  
    The data passed-in conflicted with the stored.
* ```HTTP/1.1 415 Unsupported Media Type```  
    The requested media type is not supported.  
    
##### Headers #####
* ```Location```  
    URL to the resource.

### HTTP DELETE Method ###
Example of a DELETE request:

```http://server:port/myapp/cars/1```

##### Success status code and returned body #####
* ```HTTP/1.1 203 No Content```  
    Empty body.

##### Failure status code and desciption #####
* ```HTTP/1.1 400 Bad Request```  
    The format of the client request was incorrect.
* ```HTTP/1.1 404 Not Found```  
    The requested resource does not exist.

----

## Pagination in AeroGear Controller ##
This section describes the pagination metadata expected to be passed between a client and an AeroGear Server Side endpoint (route). 

### Parameters ###
* ```offset```  
  The offset of the first element that should be included in the returned collection. Default value is _0_.
* ```limit```  
  The number of elements that should be returned. Default value is _10_.

### Metadata ###
Information about the pagination parameters, and url links to the previous and first pages need to be passed from the server to the clients. 
There are several options available here:  

*  Information is passed in a single HTTP Response Header as defined by the [Web Linking](http://tools.ietf.org/html/draft-nottingham-http-link-header-10) specification.
*  Information is passed as multiple HTTP Response Headers  

#### HTTP Response Headers ####
Web Linking returns a single response header named ```Link``` :  
* ```Link:```  
    <https://server:host/myapp/cars?offset=10&limit=10>; rel="previous",  
    <https://server:host/myapp/cars?offset=30&limit=10>; rel="next",  

Alternatively use custom HTTP response headers:

*  ```AG-Links-Previous: http://server:host/app/cars?offset=10&limit=10```   
    The url to the previous set of items
*  ```AG-Links-Next: http://server:host/app/cars?offset=20&limit=10```  
    The url to the next set of items  
    
The ```AG-``` prefix above is the default in AeroGear Controller but can be overridden if required. 

----

## AeroGear-Security ##
When AeroGear-Security is used as the SecurityProvider for AeroGear-Controller, or possibly deployed standalone, it has a number of endpoints that it exposes which handle different authentication aspects.

### Registering a user ###

```http://server:host/myapp/auth/enroll```

##### Success status code and returned body #####
* ```HTTP/1.1 200 OK```  
    The Body will contain the credentials in JSON format.

##### Failure status code and desciption #####
* ```HTTP/1.1 400 Bad Request```  
    The request could not be understood by the server due to malformed syntax.

### Login ###

```http://server:host/myapp/auth/login```

##### Success status code and returned body #####
* ```HTTP/1.1 200 OK```  
    The Body will contain the credentials in JSON format.


##### Failure status code and desciption #####
* ```HTTP/1.1 400 Bad Request```  
    The request could not be understood by the server due to malformed syntax.
* ```HTTP/1.1 401 Unauthorized```  
    The request requires user authentication.
    
### Logout ###

```http://server:host/myapp/auth/logout```

##### Success status code and returned body #####
* ```HTTP/1.1 200 OK```  
    The Body will contain the credentials in JSON format.


##### Failure status code and desciption #####
* ```HTTP/1.1 400 Bad Request```  
    The request could not be understood by the server due to malformed syntax.
* ```HTTP/1.1 401 Unauthorized``` 

#### Note: 

AeroGear Security comes with PicketLink servlet filters for Basic/Digest authentication, when enabled the endpoints above will be ignored
and AeroGear Security will make use of PicketLink authentication system.
