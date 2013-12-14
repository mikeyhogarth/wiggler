class @HomeViewModel
  constructor: () ->

    document.wiggles = {}

    $(".wiggle").each (index, element) =>
      id    = $(element).attr("id")
      avg   = $(element).data("average")
      document.wiggles[id] = new WigglyLine(id, avg)
     
    for id,wiggle of document.wiggles
      wiggle.start()
