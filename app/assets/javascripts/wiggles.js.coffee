# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class WiggleViewModel 
  constructor: (opinion, average) -> 
    @yourOpinion = ko.observable opinion
    @average = ko.observable average
    
$ ->
  initial_average = document.viewbag.initial_average
  polling_url     = document.viewbag.polling_url
  update_url      = document.viewbag.update_url

  wiggleViewModel = new WiggleViewModel("Say something :)", initial_average)
  ko.applyBindings wiggleViewModel

  update_opinion = (new_value) ->
    $.ajax update_url,
      type: 'PUT'
      data: { value: new_value },
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)
      success: (data, textStatus, jqXHR) ->
        wiggleViewModel.average(data.average)   

  $("input#your_opinion").on "change keyup", -> 
    update_opinion(this.value)

  poll_for_new_average = ->
    $.ajax polling_url,
      type: 'GET'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)
      success: (data, textStatus, jqXHR) ->
        wiggleViewModel.average(data.average)

  setInterval(poll_for_new_average, 2000)
