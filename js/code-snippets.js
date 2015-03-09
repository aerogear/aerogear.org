/**
 * This script helps to implement a multi-platform code previews.
 *
 * It is used in conjuction with Bootstrap Nav Tabs: http://getbootstrap.com/components/#nav-tabs
 *
 * <ul class="nav nav-tabs nav-snippets">
 *    <li class="active"><a href="#foo" class="btn btn-primary"> Foo</a></li>
 *    <li><a href="#bar" class="btn btn-primary"> Bar</a></li>
 * </ul>
 *
 * <pre id="foo" class="snippet-foo-bar">Foo Code</pre>
 * <pre id="bar" class="snippet-foo-bar" style="display: none">Bar Code</pre>
 *
 * Notice the use of classes `nav-snippets`, `snippet-foo-bar` and reference by IDs #foo and #bar.
 */
(function( $ ) {

  $.fn.snippetNav = function() {
    $('a', this).click(function() {
      $(this).snippetTabSwitch();
      return false;
    })
  };

  $.fn.snippetTabSwitch = function() {

    // tab activation
    var li = $(this).parent();
    var tabs = li.parent().children();
    tabs.removeClass('active');
    li.addClass('active');

    // snippet show/hide
    var snippetId = $(this).attr('href').replace(/^#/, '');
    var snippet = document.getElementById(snippetId);
    var snippetClassName;
    snippet.className.split(/\s+/).some( function( className ) {
      if ( className.match(/^snippet-/) ) {
        snippetClassName = className;
        return true;
      }
    });
    if (snippetClassName) {
      $("." + snippetClassName).hide();
      $(snippet).show();
    }
  };

  // activate all snippets in the page
  $(function() {
    $('.nav-snippets').snippetNav();
  })

}( $ ));