$(function(){
  $("a.user_recipes").on("click", function(e){

  $.get(this.href).success(function(json){
    let $ol = $('#recipes ol')
    $ol.text('')
    json.forEach(function(recipe){
      $ol.append('<li>' + recipe.name + '</li>')
    })

  })
    e.preventDefault()
  })
})
