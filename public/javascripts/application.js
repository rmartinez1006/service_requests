// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

   $(function () {
     if ($('#comments').length > 0) {
       setTimeout(updateComments, 10000);
     }
   });

   function updateComments() {
     $.getScript('/comments.js');
     setTimeout(updateComments, 10000);
   }