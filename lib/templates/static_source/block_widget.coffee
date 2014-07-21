class @Block extends Widget
  enhancePage: ->
    @bindWidgetParts()
    @bindActionHandlers()

  initialize: ->
    if @toggleButton?
      @expanded = false
      @updateToggleButton()

  extras: ->
    @element.find('p.extra')

  toggleButtonText:
    true: 'Click to show more...'
    false: 'Click to collapse...'

  updateToggleButton: ->
    @toggleButton.text(@toggleButtonText[@expanded])

  toggleExtras: (e) ->
    e.preventDefault()

    @extras().slideToggle('slow')
    @expanded = not @expanded
    @updateToggleButton()

