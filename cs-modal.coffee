class Modal
  constructor: ->
    @cssTransitions = true
    @closeButton = '#close-modal'
    @classes = 'modal'
    @keyboard = true
    @opacity = '0.7'

  init: ->
    @$body = $('body')
    @$body.append('<div id="modal-overlay"><div id="modal-wrap"><div id="modal" class="' + @classes + '">')
    @$modal = $('#modal')
    @$modalOverlay = $('#modal-overlay')

    @watchModal()

  watchModal: =>
    @$modal.on 'open', @showModal
    @$modal.on 'close', @closeModal
    @$modal.on 'click', @closeButton, @closeModal

    if @keyboard
      document.onkeydown = (e) =>
        @closeModal() if e.keyCode is 27

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
