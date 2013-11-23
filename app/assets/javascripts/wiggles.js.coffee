class WiggleViewModel 
  constructor: (opinion, average, update_url) -> 
    @_max = 100
    @_min = 0

    @update_url = update_url

    @yourOpinion = ko.observable opinion
    @average = ko.observable average
    @graph = new JustGage({
      id: "gauge", 
      value: @average(), 
      min: @_min,
      max: @_max,
      counter: true,
    }) 

  update_average: (new_value) ->
    @average(new_value)
    @graph.refresh(new_value)

  increment: ->
    @yourOpinion(parseFloat(@yourOpinion()) + 10) 
    @yourOpinion(@_max) if @yourOpinion() > @_max
  
  decrement: -> 
    @yourOpinion(parseFloat(@yourOpinion()) - 10)     
    @yourOpinion(@_min) if @yourOpinion() < @_min


class Page
  constructor: (viewModel) ->
    @viewModel = viewModel

  initialize: (opinion_up_button, opinion_down_button, opinion_slider) -> 
    self = @

    $(opinion_up_button).on "click", (e) -> 
      e.preventDefault()
      self.viewModel.increment()
      self.update_opinion()
  
    $(opinion_down_button).on "click", (e) -> 
      e.preventDefault()
      self.viewModel.decrement()
      self.update_opinion()

    $(opinion_slider).on "mouseup keyup touchend", -> 
      self.update_opinion()
  
  update_opinion: () ->
    viewModel = @viewModel

    $.ajax viewModel.update_url,
      type: 'PUT'
      data: { opinion: value: viewModel.yourOpinion() },
      dataType: 'json'
      
class @WiggleShowPageReady    
  constructor: -> 
    initial_average = document.viewbag.initial_average
    initial_opinion = document.viewbag.initial_opinion
    update_url      = document.viewbag.update_url
   
    document.wiggleViewModel = new WiggleViewModel(parseInt(initial_opinion), initial_average, update_url)  
    ko.applyBindings document.wiggleViewModel
    
    opinion_up_button         = ".opinion-up"
    opinion_down_button       = ".opinion-down"
    opinion_slider            = "input#your_opinion"
  
    page = new Page(document.wiggleViewModel)
    page.initialize(opinion_up_button, opinion_down_button, opinion_slider)
    
