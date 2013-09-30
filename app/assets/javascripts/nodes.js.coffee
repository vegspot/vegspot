# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  # Fetch page title on 'fetch title' btn click
  $('#fetch-title').on 'click', ->
    # Start post request
    $.post '/nodes/fetch_title', 
      node: { url: $('#node_url').val() }
      (data) ->
        $('#node_title').val(data.title)

  # Hide a popover when user's mouse is outside 
  # node card.
  # $('.node-single-card').hover {}, ->
  #   $('.popover').popover('hide')