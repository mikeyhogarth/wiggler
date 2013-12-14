class @WiggleViewModel
  constructor: (opinion, average, update_url, canvas_id) ->
    @UPDATE_URL = update_url

    @yourOpinion = ko.observable opinion
    @average = ko.observable average

    ko.applyBindings @

    $("input#your_opinion_slider").on "mouseup keyup touchend", (e) =>
      @updateOpinion(e.target.value)

    document.wiggles = {}
    document.wiggles[canvas_id] = new WigglyLine(canvas_id, @average())
    document.wiggles[canvas_id].start()

  incrementOpinion: ->
    @updateOpinion(parseFloat(@yourOpinion()) + 10)
  
  decrementOpinion: ->
    @updateOpinion(parseFloat(@yourOpinion()) - 10)

  updateOpinion: (new_value) ->
    @yourOpinion(new_value)
    @yourOpinion(100) if @yourOpinion() > 100
    @yourOpinion(0) if @yourOpinion() < 0
    $.ajax @UPDATE_URL,
      type: 'PUT'
      data: { opinion: value: @yourOpinion() },
      dataType: 'json'
