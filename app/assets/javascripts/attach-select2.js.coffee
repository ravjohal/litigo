# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# connecting select2 to the appropriate hooks:
#
# hard case: best_in_place's select
$ ->
 
  # first, find the mount point
  $('body').on 'best_in_place:activate', '.best_in_place', ->
 
    # second, attach empty update() to `this` to screen the downstream calls
    # which otherwise will cause an error
    @update = ->
 
    # now unbind `blur` from the <select> and bind it to the downstream
    # best_in_place's handler; this prevents the immediate select2's
    # destruction since clicking on it would cause `blur` on the downstream
    # best_in_place
    $(@).find('select').select2()
      .unbind('blur').bind('blur', {editor: @}, BestInPlaceEditor.forms.select.blurHandler)
 
# simple case: attach to a usual select
$ ->
  $('.select2').select2()
