jQuery(function($){

  $('body').scrollspy({
    target: '.sidebar',
    offset: 75
  });

  $('.sidebar > .nav').affix({
    offset: {
        top: function (){
          return (this.top = $(".main-banner").outerHeight(true)+$(".nav").outerHeight(true)+$(".breadcrumb").outerHeight(true)+30);
        },
 //       top:184,
        bottom: 558
    }
  });  


  $('.submenu').affix({
    offset: {
        top: function (){
          return (this.top = $(".main-banner").outerHeight(true));
        },
        bottom: 558
    }
  });  


  window.showShadow = function(){
   if($(window).scrollTop() === 0){
          $(".navbar").css("box-shadow", "0 0 0px rgba(0,0,0,.2)");
      }else{
          $(".navbar").css("box-shadow", "0 0 8px rgba(0,0,0,.3)");
      }
  };

  $(window).scroll(showShadow);
  showShadow();


  /**
   * scrolls to the provided anchor given by hash name (#id)
   * @param hash the name of the anchor
   * @returns {boolean} true if we found the element and scrolled to it
   */
  function scrollToHash( hash ) {
    var targetId = hash.replace(/^#/, '');
    if (targetId) {
      var target = document.getElementById(targetId);
      if (target && target.scrollIntoView) {
        var timeout = window.requestAnimationFrame || window.setTimeout;
        timeout(function () {
          location.hash = targetId;
          target.scrollIntoView(true);
          window.scrollBy(0, -70);
        });
        return true;
      }
    }
    return false;
  }

  // scroll to correct position when clicking on anchor
  $('body').on('click', 'a[href^="#"]', function() {
    var result = scrollToHash( $(this).attr('href') );
    return !result; // return false in case we were able to scroll to the element
  });
  // scroll to initial location hash
  $(function() {
    if ( location.hash ) {
      scrollToHash( location.hash );
    }
  });
    
});