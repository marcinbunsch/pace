Converter = require("converter")

class Pace

  @MAIN_UNIT: 'kph' # 'kph' or 'pace'

  @HIGHEST_SPEED: 30
  @LOWEST_SPEED: 4
  @SPEED_SPAN: @HIGHEST_SPEED - @LOWEST_SPEED

  @HIGHEST_PACE: 900
  @LOWEST_PACE: 120
  @PACE_SPAN: @HIGHEST_PACE - @LOWEST_PACE

  constructor: ->
    @windowHeight = $(window).height()
    @converter = new Converter
    @startTouchPosition = null
    @startSliderPosition = null

  start: ->
    this.setSliderY @windowHeight / 2
    this.setKph Pace.SPEED_SPAN / 2
    this.installEvents()

  installEvents: =>
    $(document).on 'touchstart', this.handleTouchStart
    $(document).on 'touchend', this.handleTouchEnd
    $(document).on 'touchmove', this.handleTouchMove

    $(document).on 'mousedown', this.handleMouseDown
    $(document).on 'mouseup', this.handleMouseUp
    $(document).on 'mousemove', this.handleMouseMove

  handleMouseDown: (e) =>
    e.preventDefault()
    this.reactToStart e.y
    return false

  handleMouseUp: (e) =>
    e.preventDefault()
    this.reactToStop()
    return false

  handleMouseMove: (e) =>
    e.preventDefault()
    this.reactToNewY(e.y) if @startSliderPosition != null
    return false

  handleTouchStart: (e) =>
    e.preventDefault()
    this.reactToStart e.touches[0].pageY
    return false

  handleTouchEnd: (e) =>
    e.preventDefault()
    this.reactToStop()

  handleTouchMove: (e) =>
    e.preventDefault()
    this.reactToNewY e.touches[0].pageY

  reactToStart: (startY) =>
    @startTouchPosition = startY
    @startSliderPosition = this.getSliderY()

  reactToStop: =>
    @startTouchPosition = null
    @startSliderPosition = null

  reactToNewY: (newY) =>
    touchDelta = newY - @startTouchPosition
    newTop = @startSliderPosition + touchDelta
    newTop = 0 if newTop < 0
    newTop = @windowHeight if newTop > @windowHeight
    percentage = newTop / @windowHeight
    this.setValue(percentage)
    this.setSliderY(newTop)

  setValue: (percentage) =>
    if Pace.MAIN_UNIT == 'kph'
      this.setValueFromKph(percentage)
    else
      this.setValueFromPace(percentage)

  setValueFromPace: (percentage) =>
    kph = Pace.SPEED_SPAN * percentage
    kph = kph + Pace.LOWEST_SPEED
    kph = Math.round(kph * 100) / 100
    this.setKph(kph)

  setValueFromKph: (percentage) =>
    pace = Pace.PACE_SPAN * percentage
    pace = pace + Pace.LOWEST_PACE
    pace = Math.round(pace * 100) / 100
    this.setPace(pace)

  setPace: (paceInSeconds) =>
    kph = @converter.convertPaceToKph(paceInSeconds)
    paceString = @converter.convertPaceToString(paceInSeconds)
    $('#speed .number').text(kph)
    $('#pace .number').text(paceString)

  setKph: (kph) =>
    paceString = @converter.convertKphToPaceString(kph)
    $('#speed .number').text(kph)
    $('#pace .number').text(paceString)

  setSliderY: (location) ->
    location = @windowHeight - 3 if location == @windowHeight
    $('#slider').css({ 'top': location + 'px' })

  getSliderY: ->
    $('#slider').offset().top

module.exports = Pace
