---
layout: post
section: docs
title: AeroGear Sync Client API Proposals
toc_generate: true
---

<span class="label label-warning">Status: Experimental</span>

## Summers' Proposal

(Java flavored)

### Overview

The Client API I propose bridges Datastores, Pipes, and Push technologies.

Currently, the user has to manually signal an intent to push his changes to a remote service.  However, the push subsystem takes care of receiving updates from a server.

This strawman is biased towards Java, but as we discuss it we can move toward a more generic document.

This straw man is still very limited.  Implementation specific limitations are described with their respective classes, but in general I have not yet proposed solutions for offline support, conflict resolution and detection, etc.

### Usage (Android)

Before we get into the APIs I would like to demonstrate a usage example for two way settings sync.

[DevNexus App demo video](https://plus.google.com/+SummersPittman/posts/HGVHwtPArPW)

#### Setup.java
    TwoWaySqlSynchronizer<UserCalendar> userCalendarSync;
    TwoWaySqlSynchronizerConfig syncConfig = new TwoWaySqlSynchronizer.TwoWaySqlSynchronizerConfig();
    syncConfig.setKlass(UserCalendar.class);
    syncConfig.setPipeConfig(userCalendarPipeConfig);
    syncConfig.setStoreConfig(userCalendarStoreConfig);

    userCalendarSync = new TwoWaySqlSynchronizer<UserCalendar>(syncConfig);

    userCalendarSync.beginSync(this, callback);

    userCalendarSync.resetToRemoteState(new Callback<List<UserCalendar>>() {
        @Override
        public void onSuccess(final List<UserCalendar> schedules) {

            mainLoopHandler.post(new Runnable() {
                @Override
                public void run() {
                    adapter.update(schedules);
                }
            });

        }

        @Override
        public void onFailure(Exception e) {
            Log.e("LOAD_CAL", e.getMessage(), e);
        }
    });


#### Syncing Changes
    userCalendarSync.sync();

#### Handling Remote Changes

    //Note, the class these methods are members of extends Fragment and implements SynchronizeEventListener<UserCalendar>

    @Override
    public void onResume() {
        super.onResume();
        userCalendarSync.addListener(this);
    }

    @Override
    public void onPause() {
        super.onPause();
        userCalendarSync.removeListener(this);
    }


    @Override
    public void dataUpdated(Collection<UserCalendar> newData) {
        adapter.update(new ArrayList<UserCalendar>(newData));
        adapter.notifyDataSetChanged();
    }

#### AndroidManifest.xml
     <receiver
            android:name="org.devnexus.sync.AeroGearGCMSyncMessageReceiver"
            android:permission="com.google.android.c2dm.permission.SEND" >
            <intent-filter>
                <action android:name="com.google.android.c2dm.intent.RECEIVE" />
                <category android:name="org.devnexus" />
            </intent-filter>
            <meta-data android:name="SYNC_PROVIDER_KEY" android:value="org.devnexus.sync.DevnexusCalendarSyncProvider"/>
            <meta-data android:name="SYNC_MESSAGE_KEY" android:value="org.devnexus.sync.UserCalendar"/>
        </receiver>


### General Classes

The following classes should be applicable over all implementations.

#### SynchronizeEventListener

Objects which implement this pattern will be notified by the sync subsystem when a change has occurred.

##### Methods

dataUpdated ***void*** **newData**
: This is called when data has been successfully synced with no conflicts.  The newData parameter is the new synced object.

resolveConflicts ***resolvedData*** **localData, remoteData**
: This is called when data needs to be resolved.  The method is provided with a copy of the local data and the remote data.  The returned value is the resolved state.  The sync subsystem will attempt to resolve the returned state with the remote server.  If this is successful, dataUpdated will be called.

#### Synchronizer

Objects which implement this pattern will be responsible for scheduling synchronization and listeners.

### Methods

addListener ***void*** **listener**
: This method registers a instance of a SynchronizeEventListener with this Synchronizer

removeListener ***void*** **listener**
: This method unregisters a instance of a SynchronizeEventListener with this Synchronizer

beginSync ***void*** **appContext**
: This method will preform all the necessary tasks for beginning synchronization including scheduling, sending tokens to the server, etc.

stopSync ***void***
: This method unregisters the app from synchronization.  It will also perform any necessary cleanup.  This method does not necessarily remove data.

loadRemoteChanges ***void***
: This method will download *update* the current working data with the remote *changes*.

sync ***void***
: Notify the synchronizer that local data has been changed and should be sent to the remote server for update.

resetToRemoteState ***void*** **Callback**
: This will download the remote data and replace the local data with it.

#### TwoWaySqlSynchronizer :: Synchronizer

This Synchronizer will examine a local data store and send changes to the server.  It does this by maintaining a reference to an external SQLStore and an internal reference to a Shadow SQL Store.  The Shadow store is updated when synchronization happens to generate a change list to send to the server or apply to the local data store.

One of the "neat" things about this synchronizer is that since GCM handles offline state, we will only receive messages when the device is online.  Thus we don't have to worry about online/offline detection.  We still have to worry about conflict detection and resolution however.

#### PeriodicReadOnlySynchronizer  :: Synchronizer

This synchronizer may store data in any store and refreshes its data from the server on a schedule provided by its config object.

#### SyncConfig

Properties on this object are used to configure Synchronizers.  Individual synchronizers may extends this class to include their own properties.

#### Properties

klass **Class**
: This is the class type of the Synchronizer.  Objects managed by the Synchronizer of are this type

pipeConfig **PipeConfig**
: The synchronizer will create a pipe based on this config to send data changes following the Pipe API.

storeConfig **StoreConfig**
: The synchronizer will use this data to create or access a local datastore.

type **SyncType**
: This is the type of synchronizer this class configures (PeriodicReadOnlySync, TwoWaySqlSync, etc)

### Android specific classes

The following classes are specific to Android but may serve as a referenc for others.

#### AeroGearGCMSyncMessageReceiver :: BroadcastReceiver

This class listens for GCM messages from Google and sends signals to a configured Synchronizer to load the remote changes.

##### Properties provided in Manifest.xml

SYNC_PROVIDER_KEY
: This is the fully qualified name of a Provider whose get method returns the Synchronizer AeroGearGCMSyncMessageReceiver is receiver messages for.

SYNC_MESSAGE_KEY
: This is a key which should be present in the GCM message to signal that which data type has been updated.  If this key is not present the Synchronizer will not be called for this message.

#### SyncTimerReceiver :: BroadcastReceiver

This class listens for Alarms invoked by the Android Alarm manager.  It will call inform a sychronizer to synchronize based on a clock.

#### Properties provided in Manifest.xml

SYNC_PROVIDER_KEY
: This is the fully qualified name of a Provider whose get method returns the Synchronizer which should be updated.

SYNC_MESSAGE_KEY
: This is a key which should be present in the alarm intent.  It will be used by the Receiver to route update messages to the correct synchronizer.


### Periodic Read Only Update

Use cases where caching data is useful and where it should be transparent and long lived are covered by this.

#### Usage proposal: Reading a schedule (Android)


    PipeConfig pipeConfig = buildConfig()

    SyncConfig syncConfig = new SyncConfig();
    syncConfig.setType(SyncTypes.PeriodicReadOnly);
    syncConfig.setExpiresIn(SyncConfig.24_HOURS);

    pipeConfig.setSync(syncConfig);

    Pipe<Schedule> schedulePipe = pipeline.pipe(pipeConfig);

    schedulePipe.read(/*call back*/);
    /*
    This will check a SQL Store, notice there is no data, fetch the data, and store metadata about when it was fetched.
    */

    //12 Hours later
    schedulePipe.read(/*call back*/);
    /*
    This will check a SQL Store, notice there is data, notice it is inside of the expires time, and return it.
    No call to the remote source will be made.
    */

    //36 Hours later
    schedulePipe.read(/*call back*/);
    /*
    This will check a SQL Store, notice there is data, notice it is stale, and refetch and refresh the data.
    */


### Topics not addressed

* Data life cycle
* Security
* Conflict detection

## Edewit's proposal

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

