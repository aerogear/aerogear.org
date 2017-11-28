---
layout: index
title: Digger
section: digger
---

<h2 class="section-header" id="digger"><img src="/img/aerogeardigger_icon_32px_cropped.png"> AeroGear<strong>Digger</strong> Guides</h2>
___
<p>
<a href="https://github.com/aerogear/digger-installer" class="btn btn-primary-inverse"><i class="fa fa-cloud-download"></i> AeroGear Digger Installer</a>
<a href="https://github.com/aerogear/digger-jenkins" class="btn btn-primary btn-sm"><i class="fa fa-github-alt"></i> View the Source</a>
</p>
___
The AeroGear Digger project allows you to set up a service to build mobile applications using OpenShift containers.

<h4 id="diggerGuides">Guides</h4>
* [Installation Guide](/docs/digger/installation)
* [Admin Guide](/docs/digger/admin)
* [Developer Guide](/docs/digger/developer)


AeroGear Digger consists of the following components:

* A Jenkins server that is used to run the build tasks
* A Docker-formated image with all the required tools to build Android applications
* macOS servers with pre-installed tools to build iOS applications (optional)
* An http://docs.ansible.com/ansible/index.html[Ansible] based automation tool used to install and configure all the components
* A nagios server for monitoring the digger components
* A suite of sample Jenkinsfiles to demonstrate how to build mobile applications using Jenkins pipeline
* [Client applications](/digger) to help you use Digger.

This project is designed to be used with the RedHat Mobile Application Platform (RHMAP).
However, it is possible to use it on its own as a CI/CD server to build mobile applications.

