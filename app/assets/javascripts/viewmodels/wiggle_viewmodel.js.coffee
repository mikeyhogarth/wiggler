class @WiggleViewModel
  constructor: (opinion, average, update_url, canvas_id) ->
    @_min = 0
    @_max = 100

    @update_url = update_url

    @yourOpinion = ko.observable opinion
    @average = ko.observable average

    @wiggly_line = new WigglyLine(canvas_id, @average())
    @wiggly_line.start()

  update_average: (new_value) ->
    @average(new_value)
    @wiggly_line.set_average(new_value)

  increment: ->
    @yourOpinion(parseFloat(@yourOpinion()) + 10)
    @yourOpinion(@_max) if @yourOpinion() > @_max
  
  decrement: ->
    @yourOpinion(parseFloat(@yourOpinion()) - 10)
    @yourOpinion(@_min) if @yourOpinion() < @_min


