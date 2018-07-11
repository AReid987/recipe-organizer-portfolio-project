$(function(){
  $("a.user_recipes").on("click", function(e){
    getUserRecipes(this)
    e.preventDefault()
  })

  $("a.all_recipes").on("click", function(e){
    getAllRecipes(this)
    e.preventDefault()
  })

})
function getUserRecipes(link){
  $.get(link.href).success(function(json){
    let $ul = $('#recipes ul')
    $ul.text('')
    let $ol = $('#recipes ol')
    $ol.text('')
    json.forEach(function(recipe){
      $ul.html('<h4><li>' + recipe.name + '</li></h4>' +
      '<h4>Instructions: </h4>' +
      '<h4><li>' + recipe.instructions + '</li></h4>')
      recipe.items.forEach(function(item){
        $ol.append('<li>' + item.ingredient.name + ' - ' + item.quantity + '</li>')
      })
    })
  })
}

function getAllRecipes(link){
  $.get(link.href).success(function(json){
    let $ol = $('#recipes ol')
    $ol.text('')
    let $ul = $('#recipes ul')
    $ul.text('')
    json.forEach(function(recipe){
      $ul.append(`<li><a href="/recipes/${recipe.id}" id="recipe${recipe.id}">${recipe.name}</a></li>`)
      $(`#recipe${recipe.id}`).on('click', function(e){
        getOneRecipe(this)
        e.preventDefault()
      })

    })
  })
}

function getOneRecipe(link){
  $.get(link.href).success(function(json){
    let $ol = $('#recipes ol')
    $ol.text('')
    let $ul = $('#recipes ul')
    $ul.text('')
    $ul.html('<h4><li>' + json.name + '</li></h4>' +
    '<h4>Instructions: </h4>' +
    '<h4><li>' + json.instructions + '</li></h4>')
    json.items.forEach(function(item){
      $ol.append('<li>' + item.ingredient.name + ' - ' + item.quantity + '</li>')
    })
    $('#recipes span').html(`<a href="#" class="js-next" data-id="${json.id}">next</a>`)
    $('.js-next').on('click', function(e){
      var nextId = parseInt($(".js-next").attr("data-id")) + 1
      $.get(`/recipes/${nextId}`).success(function(json){
        let $ol = $('#recipes ol')
        $ol.text('')
        let $ul = $('#recipes ul')
        $ul.text('')
        $ul.html('<h4><li>' + json.name + '</li></h4>' +
        '<h4>Instructions: </h4>' +
        '<h4><li>' + json.instructions + '</li></h4>')
        json.items.forEach(function(item){
          $ol.append('<li>' + item.ingredient.name + ' - ' + item.quantity + '</li>')
        })
        $('#recipes span').html(`<a href="#" class="js-next" data-id="${json.id}">next</a>`)
      })
      e.preventDefault()
    })
  })

}
