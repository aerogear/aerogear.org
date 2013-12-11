---
layout: basic
title: AeroGear Data Sync
---

# Status: Experimental

# Summersp Strawman (Java flavored)

## SynchronizeEventListener

Objects which implement this pattern will be notified by the sync subsystem when a change has occurred.

### Methods

dataUpdated ***void*** **newData**
: This is called when data has been successfully synced with no conflicts.  The newData parameter is the new synced object.

resolveConflicts ***resolvedData*** **localData, remoteData**
: This is called when data needs to be resolved.  The method is provided with a copy of the local data and the remote data.  The returned value is the resolved state.  The sync subsystem will attempt to resolve the returned state with the remote server.  If this is successful, dataUpdated will be called.

## Synchronizer

Objects which implement this patter will be responsible for scheduling synchronization and listeners.

### Methods

addListener ***void*** **listener**
: This method registers a instance of a SynchronizeEventListener with this Synchronizer

removeListener ***void*** **listener**
: This method unregisters a instance of a SynchronizeEventListener with this Synchronizer

beginSync ***void*** **appContext**
: This method will preform all the necessary tasks for beginning synchronization including scheduling, sending tokens to the server, etc.

stopSync ***void*** ****
: This method unregisters the app from synchronization.  It will also perform any necessary cleanup.  This method does not necessarily remove data.

## Topics not addressed
 
* Configuring synchronization
* Data life cycle
* Security

# Edewit's proposal

    // [option 1 fully automatic we create a pipe and add the posibilty to add a store for failover and sync just happens at on- and offline events]
    // and because merging can fail users can add a conflict handlers
     
    Builder builder = Builder.createPipe(pipeConfig).addFailoverStore(storeConfig);
    Pipe<Car> pipe = builder.pipe(Car.class);
     
    pipe.addConfictHandler(new ConflictHandler() {
      public void conflict(Field originalField, Field newField) {
      // user interaction
      }
    });
     
    // [option 2 explicit let the user specify when to sync and what to sync]
    SyncedPipe pipe = SyncPipeBuilder.build(options); // SyncPipe Store and Pipe togheter
     
    // or we only use a store to sync and tell the sync manager where to sync to
    SyncManager syncManager = new SyncManger();
    syncManger.filter(readFilter); // maybe we don't want to sync all data but just some part
     
    syncManager.addConnectionHandler(new ConnectionHandler() {
      public void onConnection() {
      syncManger.sync(pipe);
      }
    });
     
    syncManger.addConfictHandler(new ConflictHandler() {
      public void conflict(Field original, Field new) {
      // user interaction
      }
    });

