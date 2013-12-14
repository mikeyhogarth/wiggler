class @WigglyLine
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

    #one_unit_of_color = 255 / @canvas.height
    #r = parseInt(real_y_value * one_unit_of_color)
    #g = 255 - parseInt(real_y_value * one_unit_of_color)
    r = 255
    g = 255
    b = 255

    @context.beginPath()
    
    @context.lineWidth = 3
    @context.strokeStyle="rgb(#{r},#{g},#{b})"
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

