---
layout: landing-page
title: Hybrid with Cordova
section: platforms
---

<article class="push">

  <h1><i class="fa fa-simplybuilt"></i> AeroGear Cordova</h1>
  <p class="alt">AeroGear Cordova makes developing apps with Cordova easier by adding plugins for thing that are hard to do right.</p>

  <p>
    <a href="/getstarted/guides/" class="btn btn-primary"><i class="fa fa-book"></i> Guides</a>
    <a href="/getstarted/demos/#cordova" class="btn btn-primary"><i class="fa fa-cogs"></i> Demos</a>
    <a href="http://localhost:4000/docs/specs/aerogear-cordova/" class="btn btn-primary"><i class="fa fa-file-text-o"></i> API Documentation</a>
    <a href="https://github.com/aerogear/?query=cordova" class="btn btn-primary"><i class="fa fa-github-alt"></i> GitHub Repos</a>
  </p>

</article><!-- feature -->

# Cordova Plugins

{% for item in site.data.sdk['cordova']['modules'] %}
{% assign moduleName = item[0] %}
{% assign module = item[1] %}

<!-- CAPTURE DESCRIPTION -->
{% capture description %}
{% case moduleName %}
{% when 'pushplugin' %}
The Push Plugin works together with the [Unified Push Server](/docs/unifiedpush/) and because of this your javascript code can be
platform independent and [easy to setup](/docs/guides/aerogear-cordova/AerogearCordovaPush/).
{% when 'otp' %}
This plugin makes it easier to have a OTP in a secure way on Cordova. It supports QR-code reading of the secret and storing it secure on the [device natively](/docs/guides/aerogear-cordova/AerogearCordovaOTP/).
{% when 'crypto' %}
Another security based plugin, because javascript by nature is less secure and crypto algorythms take a lot of power this plugin supports basic [crypto functions natively](/docs/guides/aerogear-cordova/AerogearCordovaCrypto/).
{% when 'oauth2' %}
Last but not least is our OAuth2 Plugin that lets you do [OAuth2 based Authorization](https://github.com/aerogear/aerogear-oauth2-cordova)
{% when 'geo' %}
Creating [geo fences](/docs/specs/aerogear-cordova/geofencing.html) is a cool way to inform you users that he is getting close to a place of intrest, this plugin creates geo fences in a battery efficient way using platform specific api.
{% endcase %}
{% endcapture %}
<!-- END DESCRIPTION -->

## <i class="fa {{ site.data.modules[module.module]['icon'] }}"></i> {{ module.long-name }} Plugin
{{ description }}
{% include downloads/cordova-plugin.html moduleName=moduleName module=module %}
{% endfor %}

{% include downloads/cordova-plugin-script.html %}

---

# Roadmap
Keep an eye on our [JIRA](https://jira.jboss.org/browse/AGCORDOVA/?selectedTab=com.atlassian.jira.jira-projects-plugin:roadmap-panel) page for upcoming releases as well as what we are currently working on.

## Platforms
Right now iOS and Android are the supported platforms and we are working on supporting Window as well the Push Plugin already has Windows support. See [JIRA](https://issues.jboss.org/browse/AGCORDOVA) for things we are working on at the moment.
