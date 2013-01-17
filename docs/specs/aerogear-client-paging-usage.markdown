--- 
layout: basic 
title: AeroGear Client Paging Usage
---
## Client Paging Usage

Below is a comparison of the method usage proposed by each lib for handling paged resources.

### Enable Paging

*General Use Case* : The client configures pagging settings.

#### Android

```Java
ReadFilter filter = new ReadFilter();
filter.setLimit(7);

cars.readWithFilter(filter, new Callback<Car>() {
  @Override
  void onSuccess(List<Car> data) {
    firstPage = data;
  }
  
  @Override
  void onError(Exception ex) {
    //handle error
  }
});

```

#### iOS

```ObjC
// the AGPagedList category:
__block NSArray *_pagedList;

// start the paging........
[pipe readWithFilter:^(id<AGFilterConfig> config) {
    //set up the paging details:
    [config setLimit:3];
    [config setOffset:0];
} success:^(id responseObject) {
    // stash the "paged/query result" object (or what ever the name will be)
    _pagedList = responseObject;

    // show the results - somehwre
    NSLog(@"RESULT, PAGE 1: %@", listOfObjects);
} failure:^(NSError *error) {...}];

// get the second page.....
[_pagedList next:^(id responseObject) {
    // show the results - somehwre
    NSLog(@"RESULT, PAGE 2: %@", responseObject);
} failure:^(NSError *error) {...}];
```

#### JS

```JS
var cars = AeroGear.Pipeline({
    name: "cars",
    settings: {
        paged: "headers"
    }
}).pipes.cars;

cars.read({
    page: "next",
    success: function( data ) {
        // do something
    },
    error: function() {
        // handle it
    }
});
```


### Read Next Page

*General Use Case* : The client request the next page of a Pipe response.

*Failure Use Case* : The current page is the last page.

*Retrieving the first page* : offset must be 0.


#### Android

```Java
ReadFilter filter = new ReadFilter();
filter.setLimit(7);

cars.readWithFilter(filter, new Callback<Car>() {
  @Override
  void onSuccess(List<Car> data) {
    firstPage = data;
  }
  
  @Override
  void onError(Exception ex) {
    //handle error
  }
});


firstPage.next(new CallBack<Car>() {
  @Override
  void onSuccess(List<Car> secondPagedList) {
    //Do somethign with second Paged list
  }
  
  @Override
  void onError(Exception ex) {
    //handle error
  }
});


```

#### iOS

```ObjC
// the AGPagedList category:
__block NSArray *_pagedList;

// start the paging........
[pipe readWithFilter:^(id<AGFilterConfig> config) {
    //set up the paging details:
    [config setLimit:3];
    [config setOffset:0];
} success:^(id responseObject) {
    // stash the "paged/query result" object (or what ever the name will be)
    _pagedList = responseObject;

    // show the results - somehwre
    NSLog(@"RESULT, PAGE 1: %@", listOfObjects);
} failure:^(NSError *error) {...}];

// get the second page.....
[_pagedList next:^(id responseObject) {
    // show the results - somehwre
    NSLog(@"RESULT, PAGE 2: %@", responseObject);
} failure:^(NSError *error) {...}];
```

#### JS

```JS
cars.read({
    page: "next",
    success: function( data ) {
        // do something
    },
    error: function() {
        // handle it
    }
});
```

### Read Previous Page

*General Use Case* : The client request the previous page of a Pipe response.

*Failure Use Case* : The current page is the first page.


#### Android

```Java
ReadFilter filter = new ReadFilter();
filter.setLimit(5);
filter.setOffset(1);
cars.readWithFilter(filter, new Callback<Car>() {
  @Override
  void onSuccess(List<Car> data) {
    secondPage = data;
  }
  
  @Override
  void onError(Exception ex) {
    //handle error
  }
});

secondPage.prev(new CallBack<Car>() {
  @Override
  void onSuccess(List<Car> firstPagedList) {
    //Do somethign with second Paged list
  }
  
  @Override
  void onError(Exception ex) {
    //handle error
  }
});
```

#### iOS

```ObjC
// go backwards....,
[_pagedList previous:^(id responseObject) {
    /// do something with the payload
} failure:^(NSError *error) {...}];
```

#### JS

```JS
cars.read({
    page: "prev",
    success: function( data ) {
        // do something
    },
    error: function() {
        // handle it
    }
});
```

### Change Offset and Limit

*General Use Case* : The client changes the paging configuration mid-flight.


#### Android


```Java

ReadFilter filter = new ReadFilter();
filter.setLimit(5);
filter.setOffset(1);

cars.readWithFilter(filter, new Callback<Car>() {
  @Override
  void onSuccess(List<Car> data) {
    //do something
  }
  
  @Override
  void onError(Exception ex) {
    //handle error
  }
});


filter = new ReadFilter();
filter.setLimit(50);
filter.setOffset(0);

cars.readWithFilter(filter, new Callback<Car>() {
  @Override
  void onSuccess(List<Car> data) {
    //do something
  }
  
  @Override
  void onError(Exception ex) {
    //handle error
  }
});

```

#### iOS

```ObjC
// REDEFINE the query/pagination, and start over:
[pipe readWithFilter:^(id<AGFilterConfig> config) {
    // now we want 10 per page....
    [config setLimit:10];
  // starting at page 1.........
    [config setOffset:1];
} success:^(id responseObject) {
    // stash the "paged/query result" object (or what ever the name will be)
    _pagedList = responseObject;

    // show the results - somehwre
        NSLog(@"RESULT, PAGE 1: %@", listOfObjects);
} failure:^(NSError *error) {...}];
```

#### JS

```JS
var cars = AeroGear.Pipeline({
    name: "cars",
    settings: {
        paged: "headers"
    }
}).pipes.cars;

cars.read({
    page: "next",
    success: function( data ) {
        // do something
    },
    error: function() {
        // handle it
    }
});

cars.updatePageConfig({
    offset: 2,
    limit: 10
});

cars.read({
    page: "next",
    success: function( data ) {
        // do something
    },
    error: function() {
        // handle it
    }
});

```

### Jumping to a specific page

*General Use Case* : The client request a specific page.

*Failure Use Case* : The requested page does not exist.

#### Android


```Java

ReadFilter filter = new ReadFilter();
filter.setLimit(5);
filter.setOffset(2);

cars.readWithFilter(filter, new Callback<Car>() {
  @Override
  void onSuccess(List<Car> data) {
    //handling page 2
  }
  
  @Override
  void onError(Exception ex) {
    //handle error
  }
});

```

#### iOS

```ObjC
// REDEFINE the query/pagination, and start over:
[pipe readWithFilter:^(id<AGFilterConfig> config) {
    // now we want 10 per page....
    [config setLimit:10];
  // starting at page 1.........
    [config setOffset:1];
} success:^(id responseObject) {
    // stash the "paged/query result" object (or what ever the name will be)
    _pagedList = responseObject;

    // show the results - somehwre
        NSLog(@"RESULT, PAGE 1: %@", listOfObjects);
} failure:^(NSError *error) {...}];
```

#### JS

```JS
cars.updatePageConfig({
    offset: 2,
});

cars.read({
    success: function( data ) {
        // handle page 2
    },
    error: function() {
        // handle it
    }
});

```


### Return All Records (No longer paged)

#### Android

```Java

cars.read(new Callback<Car>() {
  @Override
  void onSuccess(List<Car> allRecords) {
   //do something 
  }
  
  @Override
  void onError(Exception ex) {
    //handle error
  }
});
```

#### iOS

```ObjC
[pipe read:^(id responseObject) {
    // do something with the response...
} failure:^(NSError *error) {...}];
```

#### JS

```JS
// Get all records for a single read but continue paging aftwerward
cars.read({
    page: false,
    success: function( data ) {
        // do something
    },
    error: function() {
        // handle it
    }
});

// Or permanently update the config to no longer page the results
cars.updatePageConfig({
    paged: false
});

cars.read({
    success: function( data ) {
        // do something
    },
    error: function() {
        // handle it
    }
});
```