#cs-modal

A simple modal library.

## Basic Usage

1. Include `cs-modal.coffee` and `cs-modal.scss` in your project.
2. Construct and initialize a modal instance.
3. Trigger the jQuery event 'open' on the element to show the modal.

## Example

```coffeescript
modal = new Modal

$ ->
  modal.init()
  $('#modal').trigger 'open'
```

## Configuration

- cssTransition: true
- closeButton: '#close-modal'
- classes: 'modal'
- keyboard: true
- opacity: '0.7'

## Events

- open
- close
- modalClosed
