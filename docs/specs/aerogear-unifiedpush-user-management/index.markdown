--- 
layout: basic 
title: AeroGear UnifiedPush Server - User Management
---

## Introduction

The goal of this document is to describe how the User Management will be implemented in the UnifiedPush Server.
   

## Roles / Permissions

There will be 3 different roles in this first version :

* _Admin_ : The Admin is like the super-user, it can access all the features of UPS including the creation of users.

* _Developer_ : The developer can create/read/update and delete Applications/variants.

* _viewer_ : Can only 'Read', can be useful for monitoring apps (or for the future UPS Forge Plugin). 

<table class="specTable">
  <thead>
    <tr>
      <th>Role</th>
      <th>Create</th>
      <th>Update</th>
      <th>Read</th>
      <th>Delete</th>
      <th>Reset secret</th>
      <th>User Mngt</th>
    </tr> 
  </thead>
  <tbody>
    <tr>
      <td>Admin</td>
      <td>X</td>
      <td>X</td>
      <td>X</td>
      <td>X</td>
      <td>X</td>
      <td>X</td>
    </tr>
    <tr>
      <td>Developer</td>
      <td>X</td>
      <td>X</td>
      <td>X</td>
      <td>X</td>
      <td>X</td>
      <td> </td>
    </tr>
    <tr>
      <td>Viewer</td>
      <td> </td>
      <td> </td>
      <td>X</td>
      <td> </td>
      <td> </td>
      <td> </td>
    </tr>
  </tbody>
</table>

## Default user creation on the first installation.

When one deploys a fresh (including an empty database) UPS distribution, by default, an user ``` admin ``` with the role ``` admin ``` is created with the default password ``` 123 ```. When he logs in for the first time, he will be asked to change his password.

## User management flow

An Admin can create new user by providing a ``` loginName ```. This will be possible through :

- The console

- The REST service

### Password Management

At creation, a "register" link will be generated and send back to the Admin UI / in the REST response.
It's the responsability of the administrator of UPS to send this link to newly created user.


#### First Login

The new user will use the "register" link to be routed to the register page when he can setup his password. Only after that, the user will be activated into the system.

#### Reset Password Instruction

If a user wants to reset his password, he has to request manually (email, post pigeon ...) to an admin. The admin resets the user and a "reset password" link, similar to the register link, will be generated.

#### Scope of the current permissions

Currently, an authenticated user can see only see his own applications / variants / installations. There is also no concept of groups, that may come in the future releases.
An admin, should be able to have access to all the applications / variants / installations.

## Security Implementation

Currently, it would be possible to implement this using Aerogear-Security-Picketlink and with some raw Picketlink : 
- Login / Logout / Registration : AG-Security offers all we need
- Roles and permissions : AG-Security offers a ``` secures ``` annotation that can be used to protect the endpoints. 

