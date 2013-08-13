# # Initialize geolocation
# initialize = ->
#   if navigator.geolocation
#     document.getElementById("status").innerHTML = "Checking..."
#     navigator.geolocation.getCurrentPosition onSuccess, onError,
#       enableHighAccuracy: true
#       timeout: 20000
#       maximumAge: 120000

#   else
#     document.getElementById("status").innerHTML = "Geolocation not supported."

# # Map position retrieved successfully
# onSuccess = (position) ->
#   data = position.coords.latitude + ' ' + position.coords.longitude
#   document.getElementById('coordinates').innerHTML = data

# # Error handler
# onError = (err) ->
#   message = undefined
#   switch err.code
#     when 0
#       message = "Unknown error: " + err.message
#     when 1
#       message = "You denied permission to retrieve a position."
#     when 2
#       message = "The browser was unable to determine a position: " + error.message
#     when 3
#       message = "The browser timed out before retrieving the position."
#   document.getElementById("status").innerHTML = message

# class window.Geolocation
#   constructor: ->
#     @form       = $('form')
#     @latitude   = $('#lat')
#     @longitude  = $('#lng')
#     @submit     = $('#submit')

#     @form.submit =>
#       navigator.geolocation.getCurrentPosition @position_ok, @position_error, enableHighAccuracy: true

#       $.ajax
#         type: "POST",
#         url: $(this).attr("action"),
#         @form.bind "ajax:success", (xhr, data, status) =>
#           console.log data
#         @form.bind "ajax:error", (event, response, erro) =>
#           console.log erro

#       # $.ajax
#       #   type: 'POST',
#       #   url: '/checking',
#       #   success: (data) ->
#       #     console.log data
#   #       before: ->
#   #         navigator.geolocation.getCurrentPosition @position_ok(), @position_error(), enableHighAccuracy: true

#   #   # @latitude = $('#lat').val
#   #   # @longitude = $('#lng').val

#   position_ok: (position) =>
#     $("#lat").val position.coords.latitude
#     $("#lng").val position.coords.longitude

#   position_error: (error) ->
#     alert "erro: " + error


position_ok = (position) ->
  $("#lat").val position.coords.latitude
  $("#lng").val position.coords.longitude

position_error = (error) ->
  alert "erro: " + error

$(document).ready ->
  return  unless navigator.geolocation
  navigator.geolocation.getCurrentPosition position_ok, position_error, enableHighAccuracy: true
