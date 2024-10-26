import $ from 'jquery';
$().ready(function () {
  // Wrap tables with a div
  if ($(".table-scroller").size() == 0) $("table").wrap("<div class='table-scroller' />")
  $(".table-scroller").css("overflow", "auto").css("-webkit-overflow-scrolling", "touch");
});