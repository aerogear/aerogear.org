--- 
layout: basic 
title: AeroGear Controller Pagination
---
## Pagination in AeroGear Controller 
Pagination is the ability to return a limited number of elements in response to a call. The number of elements returned is 
referred to as a page.   

In AeroGear Controller the strategy used for implementing pagination is using an offset/limit:  
  
* ```offset```  
  The offset of the first element that should be included in the returned collection. Default value is _0_.  
    
* ```limit```  
  The number of elements that should be returned. Default value is _10_.  
   
### Paging example
Let's look at an example of a Route with an endpoint that supports pagination:

    route()
           .from("/cars")
           .on(RequestMethod.GET)
           .produces(JSON)
           .to(Cars.class).findCarsBy(param(PaginationInfo.class), param("color"));

[PaginationInfo](http://aerogear.org/docs/specs/aerogear-controller/org/jboss/aerogear/controller/router/rest/pagination/PaginationInfo.html) is used to avoid having to add the params for ```offset``` and ```limit``` which would otherwise have 
been required:

    route()
           .from("/cars")
           .on(RequestMethod.GET)
           .produces(JSON)
           .to(Cars.class).findCarsBy(param("offset"), param("limit"), param("color"));

This might not look too bad, but imaging that you need to specify several query parameters in addition to ```color``` in the 
example above, and it can get pretty messy. So, instead we use the ```PaginationInfo``` type, which it will be populated with 
values from the request which are then available to the target method. This information can then be used by the endpoint target 
method to return a paged collection of data.
  
The target endpoint method, ```findCarsBy``` in this example, is annotated and this is where pagination can be configured:

    @Paginated 
    public List<Car> findCarsBy(PaginationInfo paginationInfo, String color) {
        return getCars(paginationInfo.getOffset(), color, paginationInfo.getLimit());
    }

### Configuration Options
The [Paginated](http://aerogear.org/docs/specs/aerogear-controller/org/jboss/aerogear/controller/router/rest/pagination/Paginated.html) 
annotation has options that can be overridden:    
  
* ```offsetParamName```  
The name of the query parameter used for the _offset_. If not specified defaults to 'offset'.  
  
* ```defaultOffset```  
The value to be used as the default 'offset' if no query parameter named 'offsetParamName' was included in the request.  
  
* ```limitParamName```  
The name of the query parameter used for the 'limit'. If not specified defaults to 'limit'.    
  
* ```defaultLimit```  
The value to be used as the default 'limit' if no query parameter named 'limitParamName' was included in the request.  
  
* ```customHeadersPrefix```  
The prefix to be used for next/previous HTTP response headers. Defaults to 'AG-'.  
   
* ```webLinking```  
Determines if Web Linking should be used, or false if custom HTTP headers should be used.  


### Linking
Related to pagination is also the ability to navigate, to get to the ```next```/```previous``` page.   

#### Web Linking  
By default AeroGear-Controller uses the [Web Linking](http://tools.ietf.org/html/rfc5988) standard.

#### Web Linking example:
    
    @Paginated 
    public List<Car> findCarsBy(PaginationInfo pinfo, String color) {
        return getCars(paginationInfo.getOffset(), color, paginationInfo.getLimit());
    }
    
The response from calling the above route would return a single header named ```Link```:   

    Link: 
    <http://host/app/cars?offset=0&color=red&limit=5>; rel="previous",  
    <http://host/app/cars?offset=10&color=red&limit=5>; rel="next"  

#### Custom Link Headers
Web Linking can be disabled in favor of the perhaps simpler option of custom headers.

#### Custom Headers with the default prefix example:
    
    @Paginated (webLinking = false)
    public List<Car> findCarsBy(PaginationInfo pinfo, String color) {
        return getCars(paginationInfo.getOffset(), color, paginationInfo.getLimit());
    }  
    
This example would use a default prefix of ```AG-``` and would return two headers:  
  
    AG-Links-Previous: http://host/app/cars?offset=0&color=red&limit=5
    AG-Links-Next:  http://host/app/cars?offset=10&color=red&limit=5
      
#### Custom Headers with custom prefix example:
    
    @Paginated (webLinking = false, customHeadersPrefix = "Test-")
    public List<Car> findCarsBy(PaginationInfo pinfo, String color) {
        return getCars(paginationInfo.getOffset(), color, paginationInfo.getLimit());
    }
    
This example would use a default prefix of ```Test-``` and would return two headers:  
  
    Test-Links-Previous: http://host/app/cars?offset=0&color=red&limit=5
    Test-Links-Next:  http://host/app/cars?offset=10&color=red&limit=5
    
### Custom Paging Strategy
This section describes how a custom pagination strategy can be implemented in AeroGear Controller.  

Depending on if you need a completely different strategy, or if you simply want to modify the returned HTTP response 
headers, you have two options:  

* Extend AbstractPaginationStrategy  
* Implement PaginationStrategy  

#### Extend AbstractPaginationStrategy
You would extend AbstractPaginationStrategy if you simply want to change/add/rename the returned HTTP response headers, 
for example: 

    public class MyStrategy extends AbstractPaginationStrategy {

        @Override
        public void setResponseHeaders(PaginationMetadata md, 
            HttpServletResponse response, 
            int resultSize) {
            for (Entry<String, String> entry : md.getHeaders(resultSize).entrySet()) {
                response.setHeader(entry.getKey(), entry.getValue());
            }
        }
    }
    
This implementation actually does exactly what the default implementation does. But you can of course modify this to suite 
your own requirements. You have access to all the 
[metadata](http://aerogear.org/docs/specs/aerogear-controller/org/jboss/aerogear/controller/router/rest/pagination/PagingMetadata.html) 
for the pagination, like the raw [links](http://aerogear.org/docs/specs/aerogear-controller/org/jboss/aerogear/controller/router/rest/pagination/Links.html) 
etc, so you could assemble headers in any way you see fit.

#### Implement PaginationStrategy
This will give you more control over the pagination strategy. The interface you have to implement is 
[PaginationStrategy](http://aerogear.org/docs/specs/aerogear-controller/org/jboss/aerogear/controller/router/rest/pagination/PaginationStrategy.html):

    public interface PaginationStrategy {
    
        PaginationInfo createPaginationInfo(RouteContext routeContext, Map<String, Object> arguments);
    
        Object[] preInvocation(PaginationInfo pagingInfo, Map<String, Object> arguments); 
    
        Object postInvocation(Object result, RouteContext routeContext, PaginationInfo pagingInfo);
    
    }

```createPaginationInfo``` is called by AeroGear Controller prior to invoking the target endpoint method. 
The arguments extracted from the current HTTP request are made available to this method. The implementation can choose whatever 
way it likes to match information from the request that are related to pagination. This could be using an annotation on the 
target endpoint method (which is what the default implementation does) or it could simply pick known parameters from the request.   
  
```preInvocation``` gives the strategy a chance to modify the actual arguments that will be used to invoke the 
target endpoint method. Depending on the concrete implementation there might not be anything to be done here other than 
returning the arguments map unchanged. But, for example the default strategy, an endpoint has the option to accept 
a _PaginationInfo_ type a parameter. In this case we have to add this instance to the arguments before calling the endpoint.  
  
```postInvocation``` is called after the target endpoint method has been invoked allows the strategy to set the 
HTTP Response headers. This method has access to the results of the invocation which it can use to decide on what links should 
be returned. For example, one might not want to return a previous or next link header if there is no more data 
(the number of items in the results is less than the limit).

#### Configuring the Strategy to be used
Simply implement the strategy as a standalone class:

    public class CustomPaginationStrategy extends AbstractPaginationStrategy {

        @Override
        public void setResponseHeaders(PaginationMetadata metadata, HttpServletResponse response, int resultSize) {
            final Map<String, String> headers = metadata.getHeaders(resultSize);
            Set<Entry<String, String>> entrySet = headers.entrySet();
            for (Entry<String, String> entry : entrySet) {
                response.setHeader(entry.getKey(), entry.getValue());
            }
        }

    }
   
