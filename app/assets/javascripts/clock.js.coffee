window.startClock = () ->
  clockobj = (if document.getElementById then document.getElementById("clock") else document.all.digitalclock)  unless standardbrowser
  Digital = new Date()
  hours = Digital.getHours()
  minutes = Digital.getMinutes()
  dn = "AM"
  dn = "PM"  if hours is 12
  dn = "PM"  if hours > 12
  hours = 0  if hours is 0
  hours = "0" + hours  if hours.toString().length is 1
  minutes = "0" + minutes  if minutes <= 9
  if standardbrowser
    if alternate is 0
      document.tick.tock.value = hours + ":" + minutes + " " + dn
    else
      document.tick.tock.value = hours + "   " + minutes + " " + dn
  else
    if alternate is 0
      clockobj.innerHTML = hours + ":" + minutes
    else
      clockobj.innerHTML = hours + ":" + minutes
  alternate = (if (alternate is 0) then 1 else 0)
  setTimeout "startClock()", 1000
alternate = 0
standardbrowser = not document.all and not document.getElementById
document.write ""  if standardbrowser
window.onload = startClock()