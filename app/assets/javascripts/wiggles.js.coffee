class WigglyLine
  constructor: (canvas_id, average) ->
    @average = average
    @canvas  = document.getElementById(canvas_id)
    @context = @canvas.getContext('2d')
    @point_size = 3
    @y_unit = @canvas.height / 100
    @current_value = @average

  start: () ->
    callback = @draw.bind(this)
    setInterval(callback, 10)

  draw: () ->
    imageData = @context.getImageData(1, 0, @canvas.width-1, @canvas.height)
    @context.putImageData(imageData, 0, 0)
    @draw_point(parseInt(@average))
    @context.clearRect(@canvas.width-1, 0, 1, @canvas.height);

  draw_point: (y) ->

    if(@current_value < y)
      @current_value += 1
    else if @current_value > y
      @current_value -= 1
    
    real_y_value = ( (@y_unit * - @current_value) ) + @canvas.height

    #@context.fillRect(@canvas.width - 10, real_y_value,@point_size,@point_size)
    @context.beginPath()
    @context.arc(@canvas.width - 10,real_y_value,3,0,2*Math.PI, true)
    @context.closePath()
    @context.fill()
    

  set_average: (new_average) ->
    @average = new_average


class WiggleViewModel
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
  constructor: (initial_average, initial_opinion, update_url) ->
  
    document.wiggleViewModel = new WiggleViewModel(parseInt(initial_opinion), initial_average, update_url, "wiggly_line")
    ko.applyBindings document.wiggleViewModel
    
    opinion_up_button         = ".opinion-up"
    opinion_down_button       = ".opinion-down"
    opinion_slider            = "input#your_opinion"
  
    page = new WiggleShowPage(document.wiggleViewModel)
    page.initialize(opinion_up_button, opinion_down_button, opinion_slider)
