 $(function() {
   $('#print').tipsy({gravity: 'ne', fade: true});
 });

 $(document).ready(function(){
   $(".toggler").click(function(e){
     e.preventDefault();
       $('.cat'+$(this).attr('data-prod-cat')).toggle();
   });
 });