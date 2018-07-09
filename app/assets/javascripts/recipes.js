$(function(){
  $("a.user_recipes").on("click", function(e){
    $.ajax({
      method: 'GET',
      url: this.href,
    }).done(function(response){
      $('#recipes').html(response)
    })
    e.preventDefault()
  })
})
