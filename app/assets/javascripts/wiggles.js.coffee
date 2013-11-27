class WigglyLine
  constructor: (canvas_id, average) ->
    @average = average
    @canvas  = document.getElementById(canvas_id)
    @context = @canvas.getContext('2d')
    @point_size = 3
    @current_value = @average
    @momentum = 0
    @max_momentum = 5

  start: () ->
    @create_requestAnimFrame_shim()
    @draw()

  draw: =>
    requestAnimationFrame(@draw, 1)
    @draw_point(parseInt(@average))
    @move_screen_to_the_left_by 1
  

  move_screen_to_the_left_by: (pixels) ->
    imageData = @context.getImageData(pixels, 0, @canvas.width-1, @canvas.height)
    @context.putImageData(imageData, 0, 0)
    @context.clearRect(@canvas.width-1, 0, 1, @canvas.height)
    
  accelerate_towards: (y) ->
    distance_to_y = Math.abs(@current_value - y)
    if(distance_to_y < 0.01)
      @current_value = y
      @momentum = 0
      return

    if(@current_value < y)
      @momentum += 0.1
    else if @current_value > y
      @momentum -= 0.1
    
    if(@momentum > @max_momentum)
      @momentum = @max_momentum
    else if @momentum < -@max_momentum
      @momentum = -@max_momentum

    @current_value += (@momentum * distance_to_y) / 100


  draw_point: (y) ->
    y_unit = @canvas.height / 100

    real_old_y_value = ( (y_unit * - @current_value) ) + @canvas.height
    @accelerate_towards y
    real_y_value = ( (y_unit * - @current_value) ) + @canvas.height

    r = parseInt(real_y_value)
    g = 255 - parseInt(real_y_value)
    
    @context.beginPath()
    @context.lineWidth = 4
    @context.strokeStyle="rgb(#{r},#{g},0)"
    @context.moveTo(@canvas.width ,real_y_value)
    @context.lineTo(@canvas.width - 1,real_old_y_value)
    @context.stroke()

  set_average: (new_average) ->
    @average = new_average
    @momentum = 0

  create_requestAnimFrame_shim: ->
    window.requestAnimationFrame ||=
    window.webkitRequestAnimationFrame ||
    window.mozRequestAnimationFrame    ||
    window.oRequestAnimationFrame      ||
    window.msRequestAnimationFrame     ||
    (callback, element) ->
      window.setTimeout( ->
      callback(+new Date()), 1000 / 60)


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
