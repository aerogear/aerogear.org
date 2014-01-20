---
layout: basic
title: AeroGear Security Overview
---

## Overview
AeroGear Security is *not* a framework, but just a small subset of classes to provide integration with security providers written in Java like [PicketLink](http://picketlink.org). It also includes some recommended practices against already known attacks.

![](../img/aerogear-security-overview.jpg)

It currently depends on any JEE application server that has
a _Context and Dependency Injection_ ([CDI](http://jcp.org/en/jsr/detail?id=299)) and can be easily integrated with any [web application](https://github.com/aerogear/aerogear-jaxrs-demo)

## License
AeroGear Security is distributed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).

## Installation

1. add the maven dependency

        <dependency>
            <groupId>org.jboss.aerogear</groupId>
            <artifactId>aerogear-security</artifactId>
            <version>1.3.1</version>
            <scope>compile</scope>
        </dependency>

2. AeroGear Security doesn't reinvent the wheel and makes use of already existing security providers. For now only PicketLink is supported:

        <dependency>
             <groupId>org.jboss.aerogear</groupId>
             <artifactId>aerogear-security-picketlink</artifactId>
             <version>1.3.1</version>
             <scope>compile</scope>
        </dependency>

## JAX-RS integration

AeroGear Security, Crypto and our client libraries are completely independent, but is possible to combine functionalities from these libraries to write any web application, not mandatory. For more information about how to create a simple project with AeroGear Security, please see the [examples](https://github.com/aerogear/aerogear-jaxrs-demo).

The first thing to do is to implement JAX-RS endpoint for the account registration:

    @Path("/register")
    public class RegisterEndpoint {

        //Only for example purposes
        public static final String DEFAULT_ROLE = "simple";

        @Inject
        private IdentityManagement configuration;

        @Inject
        private AuthenticationManager authenticationManager;

        public User register(User user, String password) {
            configuration.create(user, password);
            configuration.grant(DEFAULT_ROLE).to(user.getLoginName());
            authenticationManager.login(user, password);
            return user;
        }
    }


Now the next step is to decide which endpoint should be protected:

    @Path("/admin")
    public class AdminEndpoint {

        @DELETE
        @Path("/show/remove")
        @Produces(MediaType.APPLICATION_JSON)
        @Consumes(MediaType.APPLICATION_JSON)
        @Secure("admin")
        public List<User> remove(String username) {
            configuration.remove(username);
            return configuration.findAllByRole("simple");
        }
    }

AeroGear Security takes advantage of CDI interceptors for authorization checks, for this reason it must
be enabled at *beans.xml* file:

    <interceptors>
        <class>org.jboss.aerogear.security.interceptor.SecurityInterceptor</class>
    </interceptors>

## Enabling filters

AeroGear Security comes with servlet filters for functionalities like *HSTS* support, *Clickjacking* prevention or implementing a password recovery feature which doesn't mean you will have a bulletproof system. We're just trying to do our best to make your life easy.

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

HTML-based web applications can embed or "frame" other web pages.  Clickjacking is a type of attack that occurs when an attacker uses multiple transparent or opaque layers in the user interface to trick a user into clicking on a button or link on another page from server B when they were intending to click on the same place of the overlaying page from server A. Thus, the attacker is "hijacking" clicks meant for their page A and routing them to another page B, possibly belonging to another domain and thereby triggering actions on the second se

#### Configuration

    <filter>
        <filter-name>SecureHeadersFilter</filter-name>
        <filter-class>org.jboss.aerogear.security.web.filter.SecureHeadersFilter</filter-class>
        <init-param>
            <param-name>x-frame-options</param-name>
            <param-value>SAMEORIGIN</param-value>
        </init-param>
    </filter>

### Password Recovery

Unfortunately there's no RFC or any sort of specification about how to properly implement password recovery functionality, it sounds like a
dead simple implementation, but if you do it wrong the whole system can be compromised. For this reason we've added the bare minimum support to implement it in any web application. To properly implement it follow these steps:

1. Create a config.properties file and make sure to include a *secret_key*. It should **NEVER** be shared on GitHub.

        secret_key = "d9eb5171c59a4c817f68b0de27b8c1e340c2341b52cdbc60d3083d4e8958532" \
               "18dcc5f589cafde048faec956b61f864b9b5513ff9ce29bf9e5d58b0f234f8e3b"


    The *secret_key* is the password used to derive a cryptographic key and generate a unique url for password reseting. It was built with PBKDF2 + authenticated one-way hash function (HMAC), which means there’s no way you can pull the url id back out. 

2. This feature was designed to be agnostic of any persistence mechanism, for this reason the interface *TokenService* must be implemented.

	    public class TokenServiceImpl implements TokenService {
	
	        @Inject
	        private ExpirationTime expirationTime;
	
	        @Override
	        public void destroy(String id) {
	            try {
	                Token token = em.find(Token.class, id);
	                em.remove(token);
	                em.flush();
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	
	        @Override
	        public boolean isValid(String id) {
	
	            Token token = null;
	            try {
	                token = em.createQuery("SELECT t FROM Token t WHERE t.id = :id", Token.class)
	                        .setParameter("id", id)
	                        .getSingleResult();
	
	            } catch (NoResultException e) {
	                //Do nothing atm because we don't want to give any clue to an attacker
	            }
	
	            return (token != null && !expirationTime.isExpired(token.getExpiration()));
	        }
	
	        //Send to some place the url for password reset
	        @Override
	        public void generate(String email) {
	
	            Token token;
	
	            //Here of course we need to validate the e-mail against the database or PicketLink
	            if (FakeService.userExists(email)) {
	
	                String secret = Configuration.getSecret();
	                try {
	                    Hmac hmac = new Hmac(secret);
	                    token = save(hmac.digest());
	                    //Sending password reset instructions
	                    mail.send(Configuration.uri(token.getId()));
	                } catch (NoSuchAlgorithmException e) {
	                    e.printStackTrace();
	                } catch (InvalidKeySpecException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	    }

3. Specify the servlet filter into web.xml file.

	    <filter>
	        <filter-name>PasswordHandler</filter-name>
	        <filter-class>org.abstractj.api.filter.PasswordHandler</filter-class>
	        <init-param>
	            <param-name>url</param-name>
	            <param-value>http://localhost:8080/password-reset/</param-value>
	        </init-param>
	        <init-param>
	            <param-name>redirect-page</param-name>
	            <param-value>/reset/update.html</param-value>
	        </init-param>
	    </filter>
	
	    <filter-mapping>
	        <filter-name>PasswordHandler</filter-name>
	        <url-pattern>/reset/*</url-pattern>
	        <url-pattern>/forgot/*</url-pattern>
	    </filter-mapping>

**url**: is the address of the web application, to make it very clear here we've added the complete URL, but it could be completed with */* for example.
**redirect-page**: the page to redirect user if the URL to reset the password is valid otherwise *404* will be returned.

#### Few considerations

- The place to store the Token is totally up to the implementer: KeyStore, PicketLink or whatever database
- Tokens can be stored into the database, but for safety reasons, do not associate them with any user and make sure that they
are being properly destroyed. If an attacker hack the database and face with a table with a bunch of tokens but no relationship
with other tables, will be hard to figure out which token belongs to an specific user.
- How to properly implement it is your decision, but if you have any questions, make sure to send it to [aerogear-dev](http://aerogear-dev.1069024.n5.nabble.com). Security is a two-edged sword, is not easy, ask for feedback is the way to go.

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

## AeroGear Crypto

Symmetric APIs are easy to use, but hard to design mainly when you have 4 different platforms like JavaScript, iOS, Android and JEE. With that in mind the team has been working to support the [bare minimum](https://issues.jboss.org/browse/AGSEC-114) [set of cryptographic primitives](https://issues.jboss.org/browse/AGSEC-147).

For a more detailed look at the initial work on crypto, please refer to the [official documentation](http://aerogear.org/docs/specs/aerogear-crypto/).

## Authentication methods supported

|         | Android | iOS | JavaScript |
|:--------|:-------:|--------:|--------:|
| Rest authentication   | Yes   | Yes   | Yes   |
| Basic   | Yes   | Yes   | No   |
| Digest   | Yes   | Yes   | No   |
| SAML2   | No   | No   | No   |
| OAuth2 bearer tokens   | No   | No   | In progress   |
| Oz   | No   | No   | No   |
| Mozilla Persona   | No   | No   | No   |

### References:

- [SAML2](http://saml.xml.org/saml-specifications)
- [OAuth2 bearer tokens](http://tools.ietf.org/html/draft-ietf-oauth-jwt-bearer-04)
- [Oz](http://github.com/hueniverse/oz)
- [Mozilla Persona](http://www.mozilla.org/en-US/persona/)
