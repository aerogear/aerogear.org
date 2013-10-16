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
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.2.1/moment.min.js"></script>
<script type="text/javascript">

jQuery(function() {

    jQuery.getFeed({
        url: 'http://blog-edewit.rhcloud.com',
        success: function(feed) {
            var html = '';
            
            for(var i = 0; i < feed.items.length; i++) {
            
                var item = feed.items[i];
                
                html += '<h3>'
                + '<a href="'
                + item.link
                + '">'
                + item.title
                + '</a>'
                + '</h3>';
                
                html += '<div class="desc">'
                + moment(item.updated).fromNow()
                + '</div>';
                
                var div = document.createElement("div");
				div.innerHTML = item.description;
				var text = div.textContent || div.innerText || "";

                html += '<div>'
                + text.substring(0, 300)
                + ' ... <a href="'
                + item.link 
                +'">Read more »</a></div>';
            }
            
            jQuery('#result').append(html);
        }    
    });
});

</script>
<div id="result"></div>