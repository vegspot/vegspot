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

  # Share node links
  $('.node-share a.facebook').on 'click', ->
    window.open 'https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(this.href), 'facebook-share-dialog', 'width=626,height=436'
    false

  $('.node-share a.twitter').on 'click', (event) ->
    width  = 575
    height = 400
    left   = ($(window).width() - width) / 2
    top    = ($(window).height() - height) / 2
    url    = @href + '&via=vegspot'
    opts   = "status=1" + ",width=" + width + ",height=" + height + ",top=" + top + ",left=" + left
    window.open url, "twitter", opts
    false