$(document).ready( function(){
  $('.rli-form-add-ingredient-button').click( function(){
    console.log($('.rli-form-recipe-line-item-container').html())
    var html = $('.rli-form-recipe-line-item:first').clone()
    var newSelectIngredientName = "recipe[recipe_line_items_attributes][" + $('.rli-form-recipe-line-item').length + "][ingredient_id]"
    $(html).children('.field').children('select').attr('name', newSelectIngredientName).val('null')
    $(html).appendTo('.rli-form-recipe-line-items-container')
  });
});