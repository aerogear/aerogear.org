--- 
layout: basic 
title: AeroGear Controller Error Handling
---
## Error handling
Error handling in AeroGear Controller is done by configuring special routes for errors. Error routes do not have a ```from```
path as they merly catch exceptions which is how they are invoked. This is opposed to _normal_ routes which are invoked by 
incoming HTTP requests.

### Configuring Error views
You can configure a route as an error handler for a type of exception:

        route()
               .on(YourException.class)
               .to(ExceptionHandler.class).errorPage(); 

You can specify multiple exceptions if needed:

        route()
               .on(YourException.class, SomeOtherException.classk
               .to(ExceptionHandler.class).errorPage();
               
If you'd like to log the exception in the error route, you can specify that the target method, errorPage() above, should 
take a parameter:

        route()
               .on(YourException.class, SomeOtherException.class)
               .to(ExceptionHandler.class).errorPage(param(Exception.class));

In this case the view for ExceptionHandler would be located in:  
  
```/WEB-INF/pages/ExceptionHandler/errorPage.jsp```  

The exception is made available to the JSP page:  
  
```${requestScope['org.jboss.aerogear.controller.exception']}```  
  
    
### Configuring Error responses
You can configure an error route to respond to the caller instead of forwarding to an error view. This is useful when the
target route that was invoked ```produces``` a RESTful media type.

Example of responding with JSON:  

        route()
               .on(CarNotFoundException.class)
               .produces(JSON)
               .to(Error.class).respondWithErrorStatus(param(CarNotFoundException.class));
                
In this case the ```respondWithErrorStatus``` method could look something like this:

    public ErrorResponse respondWithErrorStatus(final CarNotFoundException e) {
        return new JsonErrorResponse(e.getStatus()).message("error", e.getMessage());
    }                

```JsonErrorResponse``` is just a convenience method and any type that implements [ErrorResponse](http://aerogear.org/docs/specs/aerogear-controller/org/jboss/aerogear/controller/router/error/ErrorResponse.html)
will work.
