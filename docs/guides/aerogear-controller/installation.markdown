--- 
layout: basic 
title: AeroGear Controller Installation
---

## Installation

### Maven dependency
Add AeroGear Controller as a maven dependency to your projects ```pom.xml```:

        <dependency>
            <groupId>org.jboss.aerogear</groupId>
            <artifactId>aerogear-controller</artifactId>
            <version>1.0.0</version>
            <scope>compile</scope>
        </dependency>
        
        
### CDI configuration
Since AeroGear Controller uses CDI it is required that a ```beans.xml``` file exists in the ```WEB-INF``` folder:

    <beans xmlns="http://java.sun.com/xml/ns/javaee"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/beans_1_0.xsd">

    </beans>  
    
By adding this file the CDI container will scan the deployment which is required so that the routes configured in the 
deployment are processed and enabled.  
See [Routes](routes.html) for more information about configuring routes.   
   
        
