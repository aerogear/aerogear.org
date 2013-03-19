# AeroGear Versioning Policy

For this 1.0.0 release and beyond we're planning some significant changes on how we do versioning for the project.

## TL;DR

We're sticking to the de-facto standard of `major`.`minor`.`patchlevel`, mostly know as Semantic Versioning, or just [semver].

## A bit of history

During the early days of the project, we started following the [JBoss Project Versioning] - at that time our assets were mostly Java. Then we found out later that we were doing it wrong, because we forgot the timestamp part of the milestone releases.

## Getting it right

So we're going to release 1.0.0 in a few days, and we'll drop the suffixes and work with versions like this:

- **bugfixes**: 
    - increment `patch` (1.0.0 -> 1.0.1)

    Bugfixes and minor changes: keeps API compatibility
- **new features and small breaking changes**:
    - increment `minor` (1.0.1 -> 1.1.0)
    
    **Small breaking changes** means that some work **may** be needed for updating beetween minor versions.
- **major releases**:
    - increment `major` (1.1.0 -> 2.0.0)

    Mostly backward incompatible changes and/or when a group of big features is ready.

Any release can use the discriminators .alpha/.beta/.pre for testing, those are sorted right.


[semver]:http://semver.org 
[JBoss Project Versioning]:https://community.jboss.org/wiki/JBossProjectVersioning