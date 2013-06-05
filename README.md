csModal
=======

A simple modal that fires via a javascript event and includes some handy-dandy auto-sizing capabilities. 


## Basic Usage

Include csModal.coffee in your project.

Add an element to your page with the id of "modal" like so:

  ````<div id="modal"></div>````
  
Trigger the jquery event 'showModal' on the element to show it.

```coffeescript
$modal = $('#modal')
$modal.trigger 'showModal'
```
