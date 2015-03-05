jQuery(function($){

$('body').scrollspy({ target: '.sidebar' });  

  $('.sidebar > .nav').affix({
    offset: {
        top: function (){
          return (this.top = $(".main-banner").outerHeight(true));
        },
        bottom: 558
//        bottom: function () {
//          return (this.bottom = $('footer').outerHeight(true) + $('.redhat').outerHeight(true));
//        }
//      bottom: function () {
//        return (this.bottom = $("footer").outerHeight(true)+$('.redhat').outerHeight(true));
//      }
    }
  });  


  $('.submenu').affix({
    offset: {
        top: function (){
          return (this.top = $(".main-banner").outerHeight(true));
        },
        bottom: 558
//        bottom: function () {
//          return (this.bottom = $('footer').outerHeight(true) + $('.redhat').outerHeight(true));
//        }
//      bottom: function () {
//        return (this.bottom = $("footer").outerHeight(true)+$('.redhat').outerHeight(true));
//      }
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



  
//   $('.submenu').affix({    
//       offset: {
//        top: function (){
//          return (this.top = $(".main-banner").outerHeight(true));
//        },
//        
//        bottom: function (){
//          return (this.bottom = $("footer").outerHeight(true)+$('.redhat').outerHeight(true));
//        }
//
//      }  
//   });


    
});