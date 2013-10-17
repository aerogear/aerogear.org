---
layout: basic
title: News
---
## AeroGear News

{% for post in site.posts %}
* [{{post.title}}]({{post.url}})
{% endfor %}

## AeroGear Blogs

<script type="text/javascript" src="/js/libs/jquery-1.10.2.js"></script>
<script type="text/javascript" src="/js/libs/jquery.jfeed.min.js"></script>
<script type="text/javascript" src="/js/libs/handlebars-1.0.0.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.2.1/moment.min.js"></script>

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

var template;

$.ajax({
    url: "template.html",
    cache: true,
    success: function(source) {
        template  = Handlebars.compile(source);
        $('#target').html(template);
    }               
}); 

$.getFeed({
  url: "http://blog-edewit.rhcloud.com",
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