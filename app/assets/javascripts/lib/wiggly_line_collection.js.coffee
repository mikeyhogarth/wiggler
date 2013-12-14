class @WigglyLineCollection
  constructor: (selector) ->
    document.wiggles = {}
  
    $(".wiggle").each (index, element) =>
      id    = $(element).attr("id")
      avg   = $(element).data("average")
      document.wiggles[id] = new WigglyLine(id, avg)

  start_wiggling: ->
    for id,wiggle of document.wiggles
      wiggle.start()
 
  
