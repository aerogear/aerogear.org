---
layout: basic
title: AeroGear Sync Data model
---
# Status: Experimental

## Data model
This data model is defined in JavaScript Object Notation (JSON) and specifies the application protocol for AeroGear Data Sync.


### JavaScript Object Notation

    {
        id: <guid>, 
        rev: <last revision>, 
        content: <arbitrary json> 
    }

#### id (String)
This is the global identifier for the object.  
This field is optional.

#### rev  (String)
The revision of this object. When a object gets updated the revision will be incremented.  
This field is optional.

#### content (Object)
This is the sync data for the application. It may be a diff, a whole object, etc.  
This field is required.


### Java

    public interface Document<T, ID> {
        public ID id;
        public String rev;
        public T content;
    }
    
_&lt;T&gt;_ is any object that can be serialized to JSON.   
_&lt;ID&gt;_ is a convenience shorthand since it's a _GUID/UUID_. _ID_ does not have to be a natural key but could be a surrogate key instead.

### Objective-C

    @interface AGDocument : NSObject

    @property (readonly) NSString* id;
    @property (readonly) NSString* rev;
    @property id content;

    @end

The dynamic _id_ type is used to store objects that can be serialized to JSON. In Objective-C that is usually _NSArray_ and _NSDictionary_.


