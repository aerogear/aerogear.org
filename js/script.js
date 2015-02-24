jQuery(function($){

$('body').scrollspy({ target: '.submenu' });  
    
    window.showShadow = function(){    
     if($(window).scrollTop() === 0){
            $(".navbar").css("box-shadow", "0 0 0px rgba(0,0,0,.2)");
        }else{
            $(".navbar").css("box-shadow", "0 0 8px rgba(0,0,0,.3)");
        }
    };
    
    $(window).scroll(showShadow);
    showShadow();



 if($(window).width() > 992){
     
   $('.aditional-actions').affix({    
       offset: {
        top: function (){
          return (this.top = $(".main-banner").outerHeight(true));
        }
      }  
   });
   
   
  $(".submenu").css("width", $('.submenu').width());
  
  
   $('.submenu').affix({    
       offset: {
        top: function (){
          return (this.top = $(".main-banner").outerHeight(true));
        },
        
//        top:105,

        bottom: function (){
          return (this.bottom = $("footer").outerHeight(true)+$('.redhat').outerHeight(true));
        }

      }  
   });
  
  




 
 }

    
});