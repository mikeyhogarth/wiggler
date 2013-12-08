class WiggleShowPage
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
  constructor: (initial_average, initial_opinion, update_url, wiggle_canvas_id) ->
  
    document.wiggleViewModel = new WiggleViewModel(parseInt(initial_opinion), initial_average, update_url, wiggle_canvas_id)
    ko.applyBindings document.wiggleViewModel
    
    opinion_up_button         = ".opinion-up"
    opinion_down_button       = ".opinion-down"
    opinion_slider            = "input#your_opinion"
  
    page = new WiggleShowPage(document.wiggleViewModel)
    page.initialize(opinion_up_button, opinion_down_button, opinion_slider)
