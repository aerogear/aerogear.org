---
layout: basic
title: AeroGear Data Sync
---

# Status: Experimental

# AeroGear Data Sync

**Note**: This document is a working progress if you strongly disagree with something, fix it.

# Documents vs Transactions


There are two "big picture" methods of doing sync.  One is a Document 
sync (Think like a gallery with videos and pictures).  Documents are 
saved, the whole document is sent to the server, then the whole document 
is pushed out to other clients who are syncing against the same source. 
  The other is a Transactional sync where many small atomic operations 
are sent to the server.  The best analog I have is Google 
Drive/operation transforms.


Obviously the server side implementations of these are hilariously 
divergent and I will leave the relative complexity of each as an 
exercise for the list.


# Background vs Foreground sync


Does the application have to be opened (foreground) for syncing to 
happen?  As far as I know, native Web requires this (barring extensions 
to the browser, plugins etc).  I think Cordova can in Android, but I 
haven't researched it.  iOS seems like a mixed bag, but generally you 
can only sync if your application is in the foreground (but you can use 
notifications and badges to communicate that there is a pending sync or 
new data). I understand there is CoreData + iCloud that is supposed to 
do something, but that seems like it is still foreground only.  On 
Android background sync is easy.


Is it OK to only have background syncing on some platforms but not others?


# Push vs Poll?


Obviously pushing updates is better for devices and users, but polling 
will let things work better for legacy services which may not have push 
support or which may be difficult to integrate into AG-Controller.


Should we support both on the clients?


# Multiple clients,multiple users, and conflicts


How do we want to support multiple users and multiple clients?  How 
should we try to do conflict resolution?  What does authorization and 
authentication look like here?


At a high level here are some options I have seen for conflict resolution:


  A.  Last in always wins.  The server explicitly trusts things in the 
order it gets and pushes that data out to users.


  B.  Clients are allowed one submit at a time and must wait for the 
server to acknowledge the receipt.  If there is a conflict the app can 
either a) merge the data, b)reload the latest from the server and make 
the user do his operation again, or c) create a new document and inform 
the user.


  C. Operation Transforms.  This was meant to solve the conflict and 
sync problem.  However it is a LOT of work


# Offline Support


Really this is more what do we want to do for coming from an "offline" 
mode to an "online" mode?  Abstractly, operations which happen offline 
are the same as operations which happen online just with a REALLY REALLY 
laggy connection. :)  We could just only viewing data when offline and 
requiring a connection for editing, queueing an upload, etc.


# How much of this is the responsibility of AG-controller vs 
underlying services?


How should the controller expose resources to clients, how should the 
controller send data to its underlying services, how much data should 
the controller be responsible itself for?


Should it be easy for an Operation Transform system to integrate with 
AeroGear-controller?

Should it be easy to write a Controller based project which polls a 
third party source?

How would the server handle passing credentials to the third party source?


## Appendix Use Cases:


Here are a few contrived use cases that we may want to keep in mind.


1.  Legacy Bug Trackers From Hell

    a.  It is a webapp written in COBOL, no one will ever EVER update or 
change the code

      b.  It has TONS of legacy but important data

      c.  It has TONS of users

      d.  It only has a few transactions per day, all creating and updating 
bug reports

      e. Multiple users can edit the same report


2.  Slacker Gallery

      a.  Each User has a multiple galleries, each gallery has multiple photos

      b.  A Gallery has only one user, but the user may be on multiple devices

      c.  Galleries may be renamed, created, and deleted

      d.  Photos may only be created or deleted.  Photos also have meta data 
which may be updated, but its creation and deletion is tied to the Photo 
object.


3.  Dropbox clone

      a.  A folder of files may be shared among users

      b.  There is a size limit to files and how much storage may be used 
per folder

      c.  Files are not updated.  If there is a new file, there is an atomic 
delete and create operation


4.  Email client

       a.  This is an AG-controller which accesses a mail account.

       b.  There are mobile offline and sync enabled clients which connect 
to this controller.


5.  Google Docs clone

       a. Operational Transform out the wazzoo

       b.  What would the server need?

       c.  What would the client need?


# Appendix Reference (Open Source) Products:


- Wave-in-a-box

- CouchDB

- Google Drive RealtimeAPI