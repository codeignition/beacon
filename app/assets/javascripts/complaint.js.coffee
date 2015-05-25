# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$( document ).ready(->
  $('.time').each (i, el)->
    $(el).html(moment($(el).html()).format('MMMM Do YYYY, h:mm:ss a'))
)
