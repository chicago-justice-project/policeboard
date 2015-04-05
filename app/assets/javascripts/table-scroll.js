// Wrap tables with a div
$(function(){
    if ($(".table-scroller").size() == 0) $("table").wrap("<div class='table-scroller' />")
    $(".table-scroller").css("overflow", "auto").css("-webkit-overflow-scrolling", "touch");
});