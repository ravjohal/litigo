$(document).ready(function() {
  $('table').on('mouseenter mouseleave', 'tr', function(){
    $('.status-circle').tipr({
      'speed': 500,
      'mode': 'top'
    });
  });
});