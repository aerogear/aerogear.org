--- 
layout: basic 
title: AeroGear Controller Overview
---

## Overview
AeroGear Controller is a very lean model view controller written in java. It focuses on the routing of HTTP requests to plain Java Object endpoint
, and the handling of the results. Results can either be forwarded to a view, or returned in the format requested by the caller.

An AeroGear Controller application is packaged as a web archive (WAR) and can be deployed to any application server that has 
a _Context and Dependency Injection_ ([CDI](http://jcp.org/en/jsr/detail?id=299)) container.
CDI is used internally and is also how the controller is configured.