class Modal
  constructor: ->
    @modalOpacity = '0.7'
    @init()

  init: ->
    @$body = $('body')
    @$body.append $('<div id="modal-overlay"></div>')
    @$modal = $('#modal')
    @$modalOverlay = $('#modal-overlay')

    @watchModals()
    @watchOverlay()

  watchModals: =>
    $closeModal = $('.close-modal')
    # Trigger 'showModal' on a modal element to trigger it
    @$modal.on 'showModal', @showModal

    $closeModal.click =>
      @closeModal()

    document.onkeydown = (e) =>
      @closeModal() if e.keyCode is 27

  showModal: (modalID) =>
    @showOverlay()
    modalHeight = @$modal.outerHeight()
    modalWidth = @$modal.outerWidth()
    windowHeight = $(window).height();

    @$modal.css
      display: "block"
      left: 50 + "%"
      position: "fixed"
      "margin-left": -(modalWidth * .5) + "px"
      "max-height": windowHeight * .75 + "px"
      opacity: 0
      top: windowHeight * .125 + "px"
      "z-index": 11000

    @$modal.fadeTo 200, 1

  closeModal: ->
    @hideOverlay()
    @$modal.fadeOut(200, =>
      @$modal.trigger('modalClosed'))

  watchOverlay: =>
    @$modalOverlay.click =>
      @closeModal()

  showOverlay: ->
    @$modalOverlay.css
      display: "block"
      opacity: 0
      'z-index': 100

    @$modalOverlay.fadeTo 200, @modalOpacity

  hideOverlay: ->
    @$modalOverlay.fadeOut 200
