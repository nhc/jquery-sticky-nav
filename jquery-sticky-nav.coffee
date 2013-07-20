#
# Name    : Sticky Nav
# Author  : Neil Charlton, bleepsystems.com, @bleepsystems
# Version : 1
# Repo    : https://github.com/nhc/jquery-sticky-nav
# Website : https://github.com/nhc/jquery-sticky-nav
#

jQuery ->

  $.stickyNav = ( element, options ) ->
    # current state
    state = ''

    # plugin settings
    options = {
      firstvisibleselector: '#branding'
      navigationseletor: 'nav'

      showfirstvisible: true
      shownav: false

      trigger: 0
    }

    # jQuery version of DOM element attached to the plugin
    @$element = $ element

    # set current state
    @setState = ( _state ) -> state = _state

    #get current state
    @getState = -> state

    # get particular plugin setting
    @getSetting = ( key ) ->
      @settings[ key ]

    # call one of the plugin setting functions
    @callSettingFunction = ( name, args = [] ) ->
      @settings[name].apply( this, args )

    @checkScroll = ->
      $set = @settings
      $(window).scroll ->
        if $(this).scrollTop() > $set.trigger 
          console.log 'hit me'

    @getTrigger = ->
      height = $(@settings.firstvisibleselector).height()
      y = $(@settings.firstvisibleselector).offset().top
      height + y

    @init = ->
      @settings = $.extend( {}, @defaults, options )

      @setState 'ready'
     
      @settings.trigger = @getTrigger()

      @checkScroll()

    # initialise the plugin
    @init()

    # make the plugin chainable
    this

  # default plugin settings
  $.stickyNav::defaults =
      message: 'Hello world'  # option description

  $.fn.stickyNav = ( options ) ->
    this.each ->
      if $( this ).data( 'pluginName' ) is undefined
        plugin = new $.stickyNav( this, options )
        $( this).data( 'pluginName', plugin )