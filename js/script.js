jQuery(function($){

$('body').scrollspy({ target: '.submenu' });  
    
    window.showShadow = function(){    
     if($(window).scrollTop() === 0){
            $(".navbar").css("box-shadow", "0 0 0px rgba(0,0,0,.2)");
        }else{
            $(".navbar").css("box-shadow", "0 0 8px rgba(0,0,0,.3)");
        }
    };
    

//    window.adjustSize = function(){
//        
//        $("#text-container").css("padding-top",0);
//        $("#illus-container").css("padding-top",0);
//    
//        var windowHeight = $(window).height();
//        var headerHeight = $(".homepage .main-banner").height();
//        var navHeight = $("nav").height();
////        var containerHeight = $(".homepage .main-banner .container").height();
//        var textHeight = $("#text-container").height();
//        var illusHeight = $("#illus-container").height();
//
//        var realHeight = (windowHeight-navHeight);
//        
//            
//            if($(window).width()<=768||$(window).height()<=(headerHeight+navHeight)){
//                $(".homepage .main-banner").css( "height", "auto");
//                $(".homepage .main-banner").css("padding-top", "10px");
//                $(".homepage .main-banner").css("padding-bottom", "10px");
//    
//            }else{
//             
//              if(illusHeight<textHeight){
//                $(".homepage .main-banner").css("height", realHeight);
//                $(".homepage .main-banner").css("padding-top", ((realHeight-textHeight)/2));
//                $(".homepage .main-banner").css("padding-bottom", "auto");
//
//                $("#illus-container").css("padding-top", ((textHeight-illusHeight)/2));
//                
//              }else{
//                           
//                $(".homepage .main-banner").css("height", realHeight);
//                $(".homepage .main-banner").css("padding-top", ((realHeight-illusHeight)/2));
//                $(".homepage .main-banner").css("padding-bottom", "auto");
//                $("#text-container").css("padding-top", ((illusHeight-textHeight)/2));
//                
//              }
//            
//            }
//    
//    
//    };
    
    $(window).scroll(showShadow);
    $(window).resize(adjustSize);
    showShadow();
    adjustSize();
    
     setTimeout(adjustSize,100);   



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