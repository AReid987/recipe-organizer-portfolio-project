$(function(){
  $("a.user_recipes").on("click", function(e){
  //   $.ajax({
  //     method: 'GET',
  //     url: this.href,
  //   }).done(function(response){
  //     $('#recipes').html(response)
  //   })
  $.get(this.href).success(function(json){
    debugger
  })
    e.preventDefault()
  })
})
