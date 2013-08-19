--- 
layout: basic 
title: AeroGear Security Overview
---

## Overview
AeroGear Security is *not* a framework, but just a small subset of classes to provide integration with security providers written in Java like [PicketLink](http://www.jboss.org/picketlink). It also includes some recommended practices against already known attacks.

It currently depends on any JEE application server that has 
a _Context and Dependency Injection_ ([CDI](http://jcp.org/en/jsr/detail?id=299)) and can be easily integrated with [AeroGear Controller](../aerogear-controller)

## License
AeroGear Security is distributed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).

## Installation 

1. add the maven dependency

        <dependency>
            <groupId>org.jboss.aerogear</groupId>
            <artifactId>aerogear-security</artifactId>
            <version>1.2.1</version>
            <scope>compile</scope>
        </dependency>
        
2. AeroGear Security doesn't reinvent the wheel and makes use of the existing security providers. For now only PicketLink is supported:

        <dependency>
             <groupId>org.jboss.aerogear</groupId>
             <artifactId>aerogear-security-picketlink</artifactId>
             <version>1.2.1</version>
             <scope>compile</scope>
        </dependency>
        
## AeroGear Controller integration

AeroGear Controller and Security are not tied together, but we've choosen to use a SPI (*Service Provider Interface*) to allow developers to easily add secured route support. For more information about how to create a simple project with AeroGear Controller, please see the [documentation](../aerogear-controller).

The first thing to do is to implement a *SecurityProvider* and include role validation:

    import org.jboss.aerogear.controller.spi.SecurityProvider;

    public class AeroGearSecurityProvider implements SecurityProvider {

        @Inject
        private IdentityManagement identityManagement;

        @Override
        public void isRouteAllowed(Route route) throws ServletException {

            if (!identityManagement.hasRoles(route.getRoles())) {
                throw new AeroGearSecurityException(HttpStatus.AUTHENTICATION_FAILED);
            }
        }
    } 
	
The next step is to configure role-based authorization support on Controller:

    public class Routes extends AbstractRoutingModule {

          /**
           * Entry point for configuring the routes mapping http requests to the pojo controllers
           */
          @Override
          public void configuration() {
              route()
                  .from("/delorean").roles("admin", "developer")
                  .on(RequestMethod.GET)
                  .to(Home.class).anotherPage();
          }
    }

	
## Enabling filters

AeroGear Security comes with a single servlet filter which can help *HSTS* support and *Clickjacking* prevention which doesn't mean you will have a bulletproof system. We're just trying to do our best to make your life easy.

### HSTS

HSTS (*HTTP Strict Transport Security*) is a security policy mechanism which enforces users to interact with SSL connections only, preventing attacks like man-in-the-middle.

This implementation is based on [RFC 6797](http://tools.ietf.org/html/rfc6797) and depends on web browser implementation. Currently this implementation is supported only in Firefox and Chrome, for further details, please check [caniuse.com](http://caniuse.com/#search=hsts) or the RFC. 

#### Common questions?


* How it will work on non supported browsers?

	- User will be redirected to HTTPS *location* attribute, but the browser won't enforce HTTPS. 
	
* Is it required on AeroGear Controller and Security?

	- No, it's an optional feature
	
* With HSTS my system is bulletproof? 

	- Only if you cut the cables and your server is hosted on an island. Security is hard.


#### Getting started


1. Configuration (*web.xml file*)

Basically, browsers that support this feature, are able to remember the fact that a particular website requires HTTPS only, upon the next visit to the site in question the agent will enforce HTTPS.

* *max-age*: set how long the agent (browser) will be remembered to force HTTPS. 
* *include-subdomain*: this rule will be applied to all the subdomains or not. (*accepted values*: true/false).
* *location:* when user try to access *http://aerogear.org* for example, the default behaviour is to response with *HTTP 301* (indicating a permanent redirect)  pointing the browser to a new location.


#### JBoss configuration file:

To get started, please install and configure SSL support on JBoss [http://docs.jboss.org/jbossweb/3.0.x/ssl-howto.html](http://docs.jboss.org/jbossweb/3.0.x/ssl-howto.html).

You can do it with:

    $JAVA_HOME/bin/keytool -genkey -alias tomcat -keyalg RSA

During the process make sure to setup the default password (*"changeit"*) already on JBoss, for testing purposes.

Copy this file [standalone.xml](https://gist.github.com/abstractj/a91c4fc960975a111803) to *$JBOSS_HOME/standalone/configuration/* and follow these steps:

1. Specify the servlet filter into web.xml and the configuration options:

       <filter>
           <filter-name>SecureHeadersFilter</filter-name>
           <filter-class>org.jboss.aerogear.security.web.filter.SecureHeadersFilter</filter-class>
           <init-param>
               <param-name>max-age</param-name>
               <param-value>2592000</param-value>
           </init-param>
           <init-param>
               <param-name>include-subdomains</param-name>
               <param-value>false</param-value>
           </init-param>
           <init-param>
               <param-name>Location</param-name>
               <param-value>https://localhost:8443/aerogear-controller-demo/mycars</param-value>
            </init-param>
       </filter>

<filter-mapping>
    	<filter-name>SecureHeadersFilter</filter-name>
    <url-pattern>/mycars/*</url-pattern>
        </filter-mapping>


2. Deploy AG Controller demo

		git@github.com:aerogear/aerogear-controller-demo.git
		cd aerogear-controller-demo 
		mvn clean package
		cp target/aerogear-controller-demo.war $JBOSS_HOME/standalone/deployments

3. Testing

	Visit [http://localhost:8080/aerogear-controller-demo](http://localhost:8080/aerogear-controller-demo) and the servlet filter will redirect you to *location* property specified into the [web.xml](https://github.com/aerogear/aerogear-controller-demo/blob/master/src/main/webapp/WEB-INF/web.xml)

4. Inspect HTTP headers on Chrome or Firefox.

### Clickjacking

*HTML-based web applications can embed or "frame" other web pages.  Clickjacking is a type of attack that occurs when an attacker uses multiple transparent or opaque layers in the user interface to trick a user into clicking on a button or link on another page from server B when they were intending to click on the same place of the overlaying page from server A. Thus, the attacker is "hijacking" clicks meant for their page A and routing them to another page B, possibly belonging to another domain and thereby triggering actions on the second server B without the knowledge nor intention of the user and potentially using an existing session context and login in that step.* - [IETF](http://tools.ietf.org/html/draft-ietf-websec-x-frame-options-02) 

#### Configuration

    <filter>
        <filter-name>SecureHeadersFilter</filter-name>
        <filter-class>org.jboss.aerogear.security.web.filter.SecureHeadersFilter</filter-class>
        <init-param>
            <param-name>x-frame-options</param-name>
            <param-value>SAMEORIGIN</param-value>
        </init-param>
    </filter>

## AeroGear OTP

To provide the maximum flexibility to each scenario OTP module was implemented completely decoupled from AeroGear Security but it is possible to use them together if you want to store and retrieve OTP secrets from PicketLink IDM. For example:

    public class Otp {

    @Inject
    @Secret
    private Instance<String> secret;

    @Inject
    @LoggedUser
    private Instance<String> loggedInUserName;

        public String secret() {
            return new Totp(secret.get()).uri(loggedInUserName.get());
        }

        public User otp(SimpleUser user, String otp) {

            Totp totp = new Totp(secret.get());
            boolean result = totp.verify(otp);

            if (!result)
                throw new RuntimeException("Invalid OTP");
        
            return user;
        }
	}

For a more detailed description of this implementation please refer to [AeroGear Security OTP](http://aerogear.org/docs/specs/aerogear-security-otp/) specification. You can see the OTP API usage [here](https://github.com/aerogear/aerogear-otp-java) or [use it with iOS](https://github.com/aerogear/aerogear-otp-ios).
