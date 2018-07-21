$(function(){
  $("a.load_comments").on("click", function(e){
    $.get(this.href).success(function(json){
      let $comments = $("#comments_div ol")
      $comments.text('')

      json.forEach(function(comment){
        $comments.append('<li>' + comment.content + '</li>')
      })
    })
    e.preventDefault()
  })

  $("#new_comment").on("submit", function(e){
    url = this.action
    data = {
      'authenticity_token': $("input[name='authenticity_token']").val(),
      'comment': {
        'content': $("#comment_content").val()
      }
    }

    $.ajax({
      type: "POST",
      url: url,
      data: data,
      success: function(response){
        $("#comment_content").val('')
        let $comments = $("#comments_div ol")
        $comments.append('<li>' + response.content + '</li>')
      }
    })
    e.preventDefault()
  })

  function showRecipe(json){
    $(".recipeName").text(json.name)
    $(".recipeInstructions").text(json.instructions)
    let $ingredients = $('.recipeIngredients ul')
    $ingredients.html('')
    json.items.forEach(function(item){
      $ingredients.append('<li>' + item.ingredient.name + ' - ' + item.quantity + '</li>')
    })
    $(".js-next").attr("data-id", json.id)
    $("a.load_comments").attr("href", "/recipes/" + json.id + "/comments")
    $("#comments_div ol").empty()
    $("#new_comment").attr("action", "/recipes/" + json.id + "/comments")
  }

  $(".js-next").on("click", function(e){
    let id = $(".js-next").attr("data-id")
    $.get("/recipes/" + id + "/next", function(json){
      showRecipe(json)
    })
    e.preventDefault()
  })

})








// $(function(){
//   $("a.user_recipes").on("click", function(e){
//
//     getUserRecipes(this)
//     e.preventDefault()
//   })
//
//   $("a.all_recipes").on("click", function(e){
//     getAllRecipes(this)
//     e.preventDefault()
//   })
//
// })
//
// function getUserRecipes(link){
//   $.get(link.href).success(function(json){
//     let $ul = $('#recipes ul')
//     $ul.text('')
//     let $ol = $('#recipes ol')
//     $ol.text('')
//     json.forEach(function(recipe){
//       $ul.append('<h4><li>' + recipe.name + '</li></h4>' +
//       '<h4>Instructions: </h4>' +
//       '<h4><li>' + recipe.instructions + '</li></h4>')
//       recipe.items.forEach(function(item){
//         $ol.append('<li>' + item.ingredient.name + ' - ' + item.quantity + '</li>')
//       })
//     })
//   })
// }
//
// function getAllRecipes(link){
//   $.get(link.href).success(function(json){
//     let $ol = $('#recipes ol')
//     $ol.text('')
//     let $ul = $('#recipes ul')
//     $ul.text('')
//     let $span = $('#recipes span')
//     $span.text('')
//     json.forEach(function(recipe){
//       $ul.append(`<li><a href="/recipes/${recipe.id}" id="recipe${recipe.id}">${recipe.name}</a></li>`)
//       $(`#recipe${recipe.id}`).on('click', function(e){
//         getOneRecipe(this)
//         e.preventDefault()
//       })
//
//     })
//   })
// }
//
// function getOneRecipe(link){
//   $.get(link.href+'.json').success(function(json){
//     let $ol = $('#recipes ol')
//     $ol.text('')
//     let $ul = $('#recipes ul')
//     $ul.text('')
//     $ul.html('<h4><li>' + json.name + '</li></h4>' +
//     '<h4>Instructions: </h4>' +
//     '<h4><li>' + json.instructions + '</li></h4>')
//     json.items.forEach(function(item){
//       $ol.append('<li>' + item.ingredient.name + ' - ' + item.quantity + '</li>')
//     })
//     //debugger
//     $('#recipes span').html(`<a href="/recipes/${json.id}.json" class="js-next" data-id="${json.id}">next</a>`)
//     $('.js-next').on('click', function(e){
//       var nextId = parseInt($(".js-next").attr("data-id")) + 1
//       getNextRecipe(nextId)
//       e.preventDefault()
//     })
//   })
//
// }
//
// function getNextRecipe(nextId){
//   //debugger
//   $.get(`/recipes/${nextId}.json`).success(function(json){
//     let $ol = $('#recipes ol')
//     $ol.text('')
//     let $ul = $('#recipes ul')
//     $ul.text('')
//     $ul.html('<h4><li>' + json.name + '</li></h4>' +
//     '<h4>Instructions: </h4>' +
//     '<h4><li>' + json.instructions + '</li></h4>')
//     json.items.forEach(function(item){
//       $ol.append('<li>' + item.ingredient.name + ' - ' + item.quantity + '</li>')
//     })
//      $(".js-next").attr("data-id", json["id"]);
//   })
// }
