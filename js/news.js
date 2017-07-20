(function ( $ ) {

  $.fn.newsSwitchSingle = function() {
    $(this).each(function() {
      var div = $(this);
      div.click(function() {
        $.allTags().tagSwitchActive( true );
        if ( div.correspondingAllSwitch().isActive() ) {
          div.correspondingAllSwitch().switchActive( false );
          div.correspondingSingleSwitches().switchActive( false );
          div.switchActive( true );
        } else {
          if ( div.isActive() ) {
            div.correspondingAllSwitch().switchActive( true );
            div.correspondingSingleSwitches().switchActive( true );
          } else {
            div.correspondingAllSwitch().switchActive( false );
            div.correspondingSingleSwitches().switchActive( false );
            div.switchActive( true );
          }
        }
        Hash.change();
        $.scrollTop();
        return false;
      });
    });
  };

  $.fn.newsSwitchAll = function() {
    $(this).each(function() {
      var div = $(this);
      div.click(function() {
        $.allTags().tagSwitchActive( true );
        div.switchActive( true );
        div.correspondingSingleSwitches().switchActive( true );
        Hash.change();
        $.scrollTop();
        return false;
      });
    });
  };

  $.fn.isActive = function() {
    return $(this).is(':has( span.label-primary )');
  };

  $.fn.isInactive = function() {
    return $(this).is(':has( span.label-default )');
  };

  $.fn.switchActive = function( active ) {
    var label = $( 'span.label', this );
    label.removeClass( active ? 'label-default' : 'label-primary' );
    label.addClass( active ? 'label-primary' : 'label-default' );
  };

  $.fn.correspondingAllSwitch = function() {
    var value = $('a', this).attr('href').replace('#', '');
    var match = value.match('^([^-]+)-');
    var prefix = match ? match[1] : value;
    return $(".checkbox." + prefix + ".all");
  };

  $.fn.correspondingSingleSwitches = function() {
    var value = $(this).find('a').attr('href').replace('#', '');
    var match = value.match('^([^-]+)-');
    var prefix = match ? match[1] : value;
    return $(".checkbox." + prefix + ":not(.all)");
  };

  $.fn.tagSwitch = function() {
    $(this).click(function() {
      if (!$.allTags().is(':not(.active)')) { // all tags are active
        $(this).tagSwitchActive( true );
      } else { // at least one tag is inactive
        if ($(this).is('.active')) {
          $(this).tagSwitchActive( false );
        } else {
          $(this).tagSwitchActive( true );
        }
      }
      // switch modules / platforms switches to all checked
      $(".checkbox.all").each(function() {
        $(this).switchActive( true );
        $(this).correspondingSingleSwitches().switchActive( true );
      });
      Hash.change();
      $.scrollTop();
      return false;
    });
  };

  $.fn.tagSwitchActive = function( active ) {
    if (active) {
      $.allTags().removeClass('active');
      $(this).addClass('active');
    } else {
      $.allTags().addClass('active');
    }
  };

  $.allTags = function() {
    return $(".tag-cloud a");
  };

  $.scrollTop = function() {
    window.scrollTo(0, 0);
  };

  var Hash = {
    state: [],
    onchange: function() {
      var hash = location.hash;
      if (hash) {
        var hashes = hash.trim().replace('#', '').replace(',', '.');
        $('.news.article').hide();
        $('.news.article.' + hashes).show();
      } else {
        $('.news.article').show();
      }
      $.scrollTop();
    },
    change: function() {
      Hash.state = [];
      // modules / platforms
      $(".checkbox.all").each(function() {
        if (!$(this).isActive()) {
          $(this).correspondingSingleSwitches().each(function() {
            if ($(this).isActive()) {
              var value = $(this).find('a').attr('href').replace('#', '');
              Hash.state.push( value );
            }
          });
        }
      });
      // tags
      if ($.allTags().is(':not(.active)')) {
        $.allTags().filter('.active').each(function() {
          console.log(this);
          var value = $(this).attr('href').replace('#', '');
          Hash.state.push( value );
        });
      }
      // change hash
      location.hash = decodeURIComponent(Hash.state);
    }
  };

  /******************/
  /* INITIALIZATION */
  /******************/
  $(window).on('hashchange', Hash.onchange);
  $(function() {
    Hash.onchange();
  });
  $(".checkbox:has(span.label a).all").newsSwitchAll();
  $(".checkbox:has(span.label a):not(.all)").newsSwitchSingle();
  $(".tag-cloud a").tagSwitch();

}( jQuery ));