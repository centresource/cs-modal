class Modal
  constructor: ->
    @modalOpacity = '0.7'
    @fadeTime = 200
    @init()

  init: ->
    @$modal = $('#modal')
    @$modalOverlay = $('<div id="modal-overlay"></div>').appendTo 'body'

    @watchModals()
    @watchOverlay()

  watchModals: =>
    $closeModal = $('.close-modal')
    # Trigger 'showModal' on a modal element to trigger it
    @$modal.on 'showModal', @showModal

    $closeModal.click @closeModal

    document.onkeydown = (e) =>
      @closeModal() if e.keyCode is 27

  showModal: (modalID) =>
    @showOverlay()
    modalHeight = @$modal.outerHeight()
    modalWidth = @$modal.outerWidth()
    windowHeight = $(window).height()

    @$modal.css
      display: "block"
      left: "50%"
      position: "fixed"
      "margin-left": -(modalWidth * .5) + "px"
      "max-height": windowHeight * .75 + "px"
      opacity: 0
      top: windowHeight * .125 + "px"
      "z-index": 11000

    @$modal.fadeTo @fadeTime, 1

  closeModal: =>
    @hideOverlay()
    @$modal.fadeOut @fadeTime, =>
      @$modal.trigger 'modalClosed'

  watchOverlay: =>
    @$modalOverlay.click @closeModal

  showOverlay: ->
    @$modalOverlay.css
      display: "block"
      opacity: 0
      'z-index': 100

    @$modalOverlay.fadeTo @fadeTime, @modalOpacity

  hideOverlay: ->
    @$modalOverlay.fadeOut @fadeTime