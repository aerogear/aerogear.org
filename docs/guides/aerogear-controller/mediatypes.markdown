--- 
layout: basic 
title: AeroGear Controller Media Types
---
## Media types
Media types are used in AeroGear Controller to determine how a request should be consumed, and what a route should produce.  
  
### Consumers
A route can specify the type of data it consumes by using the ```consumes``` method.  For example, if a route specifies a media type of ```application/json``` it will cause the body of the HTTP request to be 
transformed from JSON into a Java Object representation.  

A consumer is added to the system by adding a class that implements the [Consumer](http://aerogear.org/docs/specs/aerogear-controller/org/jboss/aerogear/controller/router/Consumer.html) interface. 
This will be picked up by the CDI container and registered for that specific content type. 

### Producers
A route can specify the type of data it produces by using the ```produces``` method. For example, if a route specifies a media type of 
```JSON``` the Java Object returned from the endpoint will be transformed into a JSON representation which will be sent back 
as the body of the HTTP response.

Adding a producer differs from adding a consumer. The reason for this is that there is a need to be able to respond 
to the same media type in different ways.  
For example, a client may request to receive content in a certain format using the 
_Accept_ header, like ```Accept: text/html```. 
But the route could choose to respond with either a dynamically generated JSP, or a static HTML page.  So there needs to be a way
for a route to specify the exact type of response handling it desires.
  
Example of a custom media type responder that returns data in a custom format to the caller:

    public class CustomResponder extends AbstractRestResponder {
    
        public static final MediaType CUSTOM_MEDIA_TYPE = new MediaType("application/custom", CustomResponder.class);

        public CustomResponder() {
            super(CUSTOM_MEDIA_TYPE);
        }

        public void writeResponse(Object entity, RouteContext routeContext) throws Exception {
            HttpServletResponse response = routeContext.getResponse();
            response.getWriter().write("CustomResponder returned: " + entity);
        }

    }
    
In the ```writeResponse``` method you have access to the entity which is what the endpoint method returned, and the RouteContext
which gives access to the HTTPServletResponse.

If you also implement [Responder](http://aerogear.org/docs/specs/aerogear-controller/org/jboss/aerogear/controller/router/Responder.html) directly if you have the 
need to forward to a view instead of responding of if you simply prefer to implement an interface.

