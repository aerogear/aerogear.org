--- 
layout: basic 
title: AeroGear Controller CORS
---
## Cross Origin Resource Sharing (CORS)
[CORS](http://www.w3.org/TR/cors/) is supported by default but can be disabled, or configured differently by implementing a CDI Producer:

    @Produces
    public CorsConfiguration demoConfig() {
        return CorsConfig.enableCorsSupport()
                .anyOrigin()
                .enableCookies()
                .exposeHeaders("accept", "links")
                .maxAge(20)
                .enableAllRequestMethods()
                .validRequestHeaders("accept", "links");
    }
    
The CDI container will detect the above annotation and inject it into AeroGear Controller.    

### Configuration Options
The CORS [Builder](http://aerogear.org/docs/specs/aerogear-controller/org/jboss/aerogear/controller/router/decorators/cors/CorsConfig.Builder.html)
contains the following methods that allow for modifying the behaviour of CORS.
  
* ```anyOrigin```  
Specifies that the HTTP response header _Access-Control-Allow-Origin_ should be set to ```*```.
  
* ```echoOrigin```  
Specifies that the HTTP response header _Access-Control-Allow-Origin_ should be set to the same value that was passed in the _Origin_ request header.
  
* ```enableCookies```  
Specifies that the HTTP response header _Access-Control-Allow-Credentials_ should be set to ```true```.  By default cookies are not included in CORS requests.

* ```disableCookies```  
Specifies that the HTTP response header _Access-Control-Allow-Credentials_ should not be returned in the response.
  
* ```exposeHeaders```  
Specifies that that HTTP respone header _Access-Control-Expose-Headers_ should be included in the response. The headers listed are
the headers that will be exposed to clients.

* ```validRequestHeaders```  
Specifies that that HTTP respone header _Access-Control-Allow-Headers_ should be included in the response. The headers listed
are the headers supported by the server.

* ```validRequestMethods```  
Specifies that that HTTP respone header _Access-Control-Allow-Methods_ should be included in the response. The HTTP methods listed
are the methods supported by the server.

* ```maxAge```  
Specifies that that HTTP respone header _Access-Control-Max-Age_ should be included in the response. Making a preflight request
on every request is expensive as the browser is making two requests for every client request. Setting this value indicates how
long the response can be cached, and during this time no preflight requests will be made.
  

### Disable CORS support ###
Example of disabling CORS support:

    @Produces
    public CorsConfiguration demoConfig() {
        return CorsConfig.disableCorsSupport();
    }