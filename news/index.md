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
{% raw  %}
<script type="text/x-handlebars-template" id="tmpl">
  {{#each feedItems}}
    <h3><a href="{{link}}" target="_blank">{{title}}</a></h3>
    <div class="desc">{{formatDate updated}}</div>
    <div>
      {{summarize description}}... <a href="{{link}}" target="_blank">Read more »</a>
    </div>
  {{/each}}
</script>
{% endraw %}

<script type="text/javascript">
Handlebars.registerHelper("formatDate", function( itemDate ) {
  return moment( itemDate ).fromNow();
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
