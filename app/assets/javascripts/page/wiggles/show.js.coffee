class @WiggleShowPageReady
  constructor: (initial_average, initial_opinion, update_url) ->
    document.viewModel = new WiggleViewModel(parseInt(initial_opinion), initial_average, update_url)
 
