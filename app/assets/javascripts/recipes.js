$(function(){
  $("a.user_recipes").on("click", function(e){

  $.get(this.href).success(function(json){
    let $ul = $('#recipes ul')
    $ul.text('')
    let $ol = $('#recipes ol')
    $ul.text('')
    json.forEach(function(recipe){
      $ul.html('<h4><li>' + recipe.name + '</li></h4>' +
      '<h4>Instructions: </h4>' +
      '<h4><li>' + recipe.instructions + '</li></h4>')
      recipe.items.forEach(function(item){
        $ol.append('<li>' + item.ingredient.name + ' - ' + item.quantity + '</li>')
      })
    })
  })
    e.preventDefault()
  })

  $("a.all_recipes").on("click", function(e){
    $.get(this.href).success(function(json){
      debugger 
    })
    e.preventDefault()
  })

})
