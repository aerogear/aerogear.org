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
Let's look at an example of what a Route with an endpoint that supports pagination looks like:

    route()
           .from("/cars")
           .on(RequestMethod.GET)
           .produces(JSON)
           .to(Cars.class).findCarsBy(param(PaginationInfo.class), param("color"));

```PaginationInfo``` is used to avoid having to add the params for ```offset``` and ```limit``` which would otherwise have 
been required:

    route()
           .from("/cars")
           .on(RequestMethod.GET)
           .produces(JSON)
           .to(Cars.class).findCarsBy(param("offset"), param("limit"), param("color"));

This might not look too bad, but imaging that you need to specify several query parameters in addition to ```color``` in the 
example above, and it can get pretty messy. So, instead we use the ```PaginationInfo``` type which it will be populated with 
the request values which are then available to the target method. This information can then be used by the endpoint target 
method to return a paged collection of data.
  
The target endpoint method, ```findCarsBy```, is annotated and this is where pagination can be configured:

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
    
The response from calling the above route might would return a single header named ```Link```:   

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
   
