class Modal
  constructor: ->
    @cssTransitions = true
    @closeButton = '#close-modal'
    @classes = 'modal'
    @keyboard = true
    @opacity = '0.7'

  init: ->
    @$document = $(document)
    @$body = $('body')
    @$body.append('<div id="modal-overlay"><div id="modal-wrap"><div id="modal" class="' + @classes + '">')
    @$modal = $('#modal')
    @$modalOverlay = $('#modal-overlay')

    @watchModal()

  watchModal: =>
    @$modal.on 'open',  @showModal
    @$modal.on 'open',  @disableBodyScroll
    @$modal.on 'close', @closeModal
    @$modal.on 'close', @enableBodyScroll
    @$modal.on 'click', @closeButton, => @$modal.trigger 'close'

    if @keyboard
      document.onkeydown = (e) =>
        @$modal.trigger 'close' if e.keyCode is 27

  showModal: =>
    @$modalOverlay.show()
    @$body.addClass('modal-active')
    # @watchOverlay()
    @$modal.show()


  closeModal: =>
    @$body.removeClass('modal-active')
    @hideOverlay()
    @$modal.hide()
           .html('')
           .trigger('modalClosed')

  watchOverlay: =>
    @$body.on 'click', ':not("#modal")', (e) =>
      e.stopPropagation()
      @closeModal()

  showOverlay: ->
    @$modalOverlay.show()

  hideOverlay: ->
    if @cssTransitions
      events = 'transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd'
      @$modalOverlay.on events, =>
        @$modalOverlay.hide()
                      .off(events)
    else
      @$modalOverlay.hide()

  disableBodyScroll: =>
    @$document.on 'touchmove', (e) ->
      e.preventDefault()

    @$body.on 'touchstart', '#modal-overlay', (e) ->
      if e.currentTarget.scrollTop == 0
        e.currentTarget.scrollTop = 1
      else if e.currentTarget.scrollHeight == e.currentTarget.scrollTop + e.currentTarget.offsetHeight
        e.currentTarget.scrollTop -= 1

    @$body.on 'touchmove', '#modal-overlay', (e) ->
      e.stopPropagation()

  enableBodyScroll: =>
    @$document.off 'touchmove'
    @$body.off 'touchmove, touchstart'
