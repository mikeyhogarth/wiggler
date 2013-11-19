class WiggleViewModel 
  constructor: (opinion, average) -> 
    @max = 100
    @min = 0

    @yourOpinion = ko.observable opinion
    @average = ko.observable average
    @graph = new JustGage({
      id: "gauge", 
      value: @average(), 
      min: @min,
      max: @max,
      counter: true,
    }) 

  update_average: (new_value) ->
    @average(new_value)
    @graph.refresh(new_value)

  increment: ->
    @yourOpinion(parseFloat(@yourOpinion()) + 1) 
    @yourOpinion(@max) if @yourOpinion() > @max
  
  decrement: -> 
    @yourOpinion(parseFloat(@yourOpinion()) - 1)     
    @yourOpinion(@min) if @yourOpinion() < @min

class Page
  constructor: (initial_average, initial_opinion, update_url) ->
    @initial_average = initial_average
    @initial_opinion = initial_opinion
    @update_url = update_url

  initialize: -> 
    update_opinion = @update_opinion
    update_url = @update_url

    $(".opinion-up").on "click", (e) -> 
      e.preventDefault()
      document.wiggleViewModel.increment()
      update_opinion(update_url)
  
    $(".opinion-down").on "click", (e) -> 
      e.preventDefault()
      document.wiggleViewModel.decrement()
      update_opinion(update_url)

    $("input#your_opinion").on "mouseup keyup touchend", -> 
      update_opinion(update_url)
  
  update_opinion: (update_url) ->
    $.ajax update_url,
      type: 'PUT'
      data: { opinion: value: document.wiggleViewModel.yourOpinion() },
      dataType: 'json'


$ ->
  initial_average = document.viewbag.initial_average
  update_url      = document.viewbag.update_url
  initial_opinion = document.viewbag.initial_opinion

  document.wiggleViewModel = new WiggleViewModel(parseFloat(initial_opinion), initial_average)  
  ko.applyBindings document.wiggleViewModel
  
  page = new Page(initial_average, initial_opinion, update_url);
  page.initialize()
 
