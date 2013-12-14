class @HomeViewModel
  constructor: () ->
    wiggles = new WigglyLineCollection(".wiggle")
    wiggles.start_wiggling()
