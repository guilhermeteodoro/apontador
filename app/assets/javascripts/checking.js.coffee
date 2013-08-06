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

position_ok = (position) ->
  $("#checking_lat").val position.coords.latitude
  $("#checking_lng").val position.coords.longitude

position_error = (error) ->
  alert "erro: " + error

$(document).ready ->
  return  unless navigator.geolocation
  navigator.geolocation.getCurrentPosition position_ok, position_error, enableHighAccuracy: true