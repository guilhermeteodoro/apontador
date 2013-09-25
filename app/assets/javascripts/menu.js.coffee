$(".nav-header").addClass "closed"
$(".nav-header").after "<a href=\"#\" class=\"nav-toggle\">Menu</a>"
$(".nav-toggle").click ->
  h = $(".listaNav").height()
  if $(".nav-header").hasClass("closed")
    $(".nav-header").animate(
      height: h
    ,
      queue: false
      duration: 200
    ).removeClass "closed"
  else
    $(".nav-header").animate(
      height: "0px"
    ,
      queue: false
      duration: 200
    ).addClass "closed"

$(window).resize ->
  tamanhoViewport = $(window).width()
  if tamanhoViewport > 800
    $(".nav-header").css("height", "auto").addClass "closed"
  else
    $(".nav-header").css("height", "0px").addClass "closed"