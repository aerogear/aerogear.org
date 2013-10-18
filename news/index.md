---
layout: basic
title: News
---
## AeroGear News

{% for post in site.posts %}
* [{{post.title}}]({{post.url}})
{% endfor %}

## AeroGear Blogs

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
Handlebars.registerHelper("summarize", function( description ) {
    var div = document.createElement("div");
    div.innerHTML = description;
    var text = div.textContent || div.innerText || "";
    return text.substring(0, 300);
});

var blogTemplate = Handlebars.compile($('#tmpl').html());

$.getFeed({
  url: "http://aggregator-aerogear.rhcloud.com",
  success: function( feed ) {
    $("#result").append(
      blogTemplate({
        feedItems: feed.items
      })
    );
  }
});

</script>
<div id="result"></div>