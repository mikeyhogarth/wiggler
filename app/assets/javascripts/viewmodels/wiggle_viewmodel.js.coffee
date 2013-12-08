class @WiggleViewModel
  constructor: (opinion, average, update_url, canvas_id) ->
    @_min = 0
    @_max = 100

    @update_url = update_url

    @yourOpinion = ko.observable opinion
    @average = ko.observable average

    document.wiggles = {}
    document.wiggles[canvas_id] = new WigglyLine(canvas_id, @average())
    document.wiggles[canvas_id].start()

  increment: ->
    @yourOpinion(parseFloat(@yourOpinion()) + 10)
    @yourOpinion(@_max) if @yourOpinion() > @_max
  
  decrement: ->
    @yourOpinion(parseFloat(@yourOpinion()) - 10)
    @yourOpinion(@_min) if @yourOpinion() < @_min


