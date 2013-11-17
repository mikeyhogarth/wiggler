class WiggleViewModel 
  constructor: (opinion, average) -> 
    @max = 10
    @min = 0

    @yourOpinion = ko.observable opinion
    @average = ko.observable average
  
  increment: ->
    @yourOpinion(parseFloat(@yourOpinion()) + 1) 
    @yourOpinion(@max) if @yourOpinion() > @max
  
  decrement: -> 
    @yourOpinion(parseFloat(@yourOpinion()) - 1)     
    @yourOpinion(@min) if @yourOpinion() < @min


$ ->
  initial_average = document.viewbag.initial_average
  polling_url     = document.viewbag.polling_url
  update_url      = document.viewbag.update_url
  initial_opinion = document.viewbag.initial_opinion

  wiggleViewModel = new WiggleViewModel(parseFloat(initial_opinion), initial_average)
  ko.applyBindings wiggleViewModel

  update_opinion = (new_value) ->
    $.ajax update_url,
      type: 'PUT'
      data: { opinion: value: wiggleViewModel.yourOpinion() },
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)
      success: (data, textStatus, jqXHR) ->
        wiggleViewModel.average(data.average)   

  $(".opinion-up").on "click", (e) -> 
    e.preventDefault()
    wiggleViewModel.increment()
    update_opinion()

  $(".opinion-down").on "click", (e) -> 
    e.preventDefault()
    wiggleViewModel.decrement()
    update_opinion()

  $("input#your_opinion").on "mouseup keyup touchend", -> 
    update_opinion()

  poll_for_new_average = ->
    $.ajax polling_url,
      type: 'GET'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)
      success: (data, textStatus, jqXHR) ->
        wiggleViewModel.average(data.average)

  setInterval(poll_for_new_average, 2000)
