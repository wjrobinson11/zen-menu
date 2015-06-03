$(document).ready( function(){
  $('.rli-form-add-ingredient-button').click( function(){
    console.log($('.rli-form-recipe-line-item-container').html())
    var html = $('.rli-form-recipe-line-item:first').clone()
    var newSelectIngredientName = "recipe[recipe_line_items_attributes][" + $('.rli-form-recipe-line-item').length + "][ingredient_id]"
    var newQuantityName = "recipe[recipe_line_items_attributes][" + $('.rli-form-recipe-line-item').length + "][quantity]"
    $(html).children('.field').children('select.ingredients-dropdown').attr('name', newSelectIngredientName).val('')
    $(html).children('.rli-form-quantity-container').children('.field').children('.rli-quantity').attr('name', newQuantityName).attr('value','')
    $(html).children('.rli-form-quantity-container').children('.rli-form-unit-of-measurement-container').html('')
    $(html).appendTo('.rli-form-recipe-line-items-container')
  });
});