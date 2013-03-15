--- 
layout: basic 
title: AeroGear Controller Routes
---

## Configuring Routes
Configuration of routes in AeroGear Controller is done programatically using fluent API.   

### Configuration methods  
The simplest way to configure routes is to extend [AbstractRoutingModule](http://aerogear.org/docs/specs/aerogear-controller/org/jboss/aerogear/controller/router/AbstractRoutingModule.html):  

    public class Routes extends AbstractRoutingModule {

        @Override
        public void configuration() {
            route()
                   .from("/").roles("admin")
                   .consumes(JSP, JSON)
                   .on(RequestMethod.GET)
                   .produces(JSP, JSON)
                   .to(Home.class).index();
            }
        }

  
* ```from```  
The HTTP path that this route will service request for.  

* ```roles```  
Roles that the currently authenticated subject must belong to for this route to be invoked. 

* ```on```  
The HTTP [method(s)](http://aerogear.org/docs/specs/aerogear-controller/org/jboss/aerogear/controller/router/RequestMethod.html) that this route can handle.  

* ```consumes```  
The [Media Types](mediatypes.html) that this route can consume.  

* ```produces```  
The [Media Types](mediatypes.html) that this route can produce.  

* ```to```  
The target endpoint class for this route. 


### MVC Routes
These are routes that forward the result produced by the endpoint to a view. This is the default in AeroGear Controller if no
```consumes``` method has been specified. See [Media Types](mediatypes.html) for more information regarding the consumes method.  

Example of MVC Route:
  
    public class Routes extends AbstractRoutingModule {

        @Override
        public void configuration() {
            route()
                   .from("/")
                   .on(RequestMethod.GET)
                   .to(Home.class).index();
            }
        }

Next, create a POJO for the endpoint ```Home```:

        public class Home {
            public void index() {
            }
        }
        
Finally, create a JSP page at `/WEB-INF/pages/<Controller Class Name>/<method>.jsp`

        <!-- /WEB-INF/pages/Home/index.jsp -->
        <html>
            <body>
                <p>hello from index!</p>
            </body>
        </html>
        
If you have deployed your application with a context path of _myapp_, you could then access the view by pointing a browser to:  
  
```http://server:port/myapp/```  
  
    

### RESTful Routes
Routes that should return data to the caller are configured in the same way as an MVC route, except instead of forwarding to a view
, a RESTful route will specify that it ```produces``` a [Media Type](mediatypes.html) that returns data to the client in the 
format requested.

Example of RESTful Route:

    public class Routes extends AbstractRoutingModule {

        @Override
        public void configuration() {
            route()
                   .from("/cars/{id}")
                   .on(RequestMethod.GET)
                   .produces(JSON)
                   .to(Cars.class).findById(param("id"));
        }
        
A GET request to the above route might look like:  
```http://server:port/myapp/cars/3```  

This route returned list of cars in [JSON](http://www.json.org/) format. The built-in JSON support is provided by [Jackson](http://jackson.codehaus.org).  
If you are not happy with the built-in consumers or produces you can provide your own, please refer to the section [Media Types](mediatypes.html) for further details.

## Parameters
Route endpoints currently support the following types of parameters which are all configured by using the ```param``` method:  
  
* ```Path```  
  
* ```Query```   
  
* ```Form```  
  
* ```Header```  
  
* ```Cookie```   

### Populating parameters
You can use immutable beans straight away as controller parameters:

        public class Cars {
            public Car save(Car car) {
                return car;
            }
        }

This can be populated by putting a route to it (preferably via post, of course)

        route()
               .from("/cars")
               .on(RequestMethod.POST)
               .to(Cars.class).save(param(Car.class));


And you can use a simple html form for it, by just following the convention:

        <input type="text" name="car.color"/>
        <input type="text" name="car.brand"/>

The car object will be automatically populated with the provided values - note that it supports deep linking, so this would work fine too:

        <input type="text" name="car.brand.owner"/>

All the intermediate objects are created automatically.
