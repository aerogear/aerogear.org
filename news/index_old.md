---
layout: basic
title: News
---
## AeroGear News

{% for post in site.posts %}
*  {{post.date |  date: "%-d %b %Y" }} - [{{post.title}}]({{post.url}})
{% endfor %}

## AeroGear Blogs

<script type="text/javascript" src="/js/libs/jquery-1.10.2.js"></script>
<script type="text/javascript" src="/js/libs/jquery.jfeed.min.js"></script>
<script type="text/javascript" src="/js/libs/handlebars-1.0.0.min.js"></script>
<script type="text/javascript" src="/js/libs/moment.min.js"></script>
<script type="text/javascript" src="/js/libs/md5-3.1.2.js"></script>
<style type="text/css">
  .avatar {
    width: 10%;
    float: left;
    display: inline-block;
    padding-right: 0.5em;
  }
</style>

{% raw  %}
<script type="text/x-handlebars-template" id="tmpl">
  {{#each feedItems}}
    <div>
      <h3><a href="{{link}}" target="_blank">{{title}}</a></h3>
      <div class="avatar">
        <img src="http://www.gravatar.com/avatar/{{avatar author}}">
      </div>
      <div>
        <div class="desc">{{formatDate updated}} by {{creator}}</div>
        <div>
          {{summarize description}}... <a href="{{link}}" target="_blank">Read more »</a>
        </div>
      </div>
    <div>
  {{/each}}
</script>
{% endraw %}

<script type="text/javascript">
Handlebars.registerHelper("formatDate", function( itemDate ) {
  return moment( itemDate ).fromNow();
});

Handlebars.registerHelper("avatar", function( author ) {
  return CryptoJS.MD5( author );
});

Handlebars.registerHelper("summarize", function( description ) {
    var div = document.createElement("div");
    div.innerHTML = description;
    var text = div.textContent || div.innerText || "";
    return text.substring(0, 300);
});

var template = Handlebars.compile($('#tmpl').html());

$.getFeed({
  url: "http://aggregator-aerogear.rhcloud.com",
  success: function( feed ) {
    $("#result").append(
      template({
        feedItems: feed.items
      })
    );
  }
});

</script>
<div id="result"></div>
