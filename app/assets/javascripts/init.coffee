$.rails.allowAction = (element) ->
  # The message is something like "Are you sure?"
  message = element.data('confirm')
  # If there's no message, there's no data-confirm attribute,
  # which means there's nothing to confirm
  return true unless message
  # Clone the clicked element (probably a delete link) so we can use it in the dialog box.
  $link = element.clone()
  # We don't necessarily want the same styling as the original link/button.
  .removeAttr('class')
  # We don't want to pop up another confirmation (recursion)
  .removeAttr('data-confirm')
  # We want a button
  .addClass('btn').addClass('btn-danger')
  # We want it to sound confirmy
  .html("Ok")

  # Create the modal box with the message
  modal_html = """
               <div class="modal modal-fade">
                <div class='modal-dialog'>
                   <div class='modal-content'>
                    <div class="modal-header">
                    <a class="close" data-dismiss="modal">×</a>
                    <h4 class='modal-title'>Sacobs</h4>
                    </div>
                    <div class="modal-body">
                    <p>#{message}</p>
                    </div>
                    <div class="modal-footer">
                    <a data-dismiss="modal" class="btn btn-default">Cancel</a>
                    </div>
                  </div>
                </div>
               </div>
               """
  $modal_html = $(modal_html)
  # Add the new button to the modal box
  $modal_html.find('.modal-footer').append($link)
  # Pop it up
  $modal_html.modal()
  # Prevent the original link from working
  return false


$(document).on "turbolinks:load", ->
  $.bootstrapSortable(applyLast=true)

  $('[data-toggle=tooltip]').tooltip()
  $('.datepicker').datepicker(
    autoclose: true,
    autoSize: true,
    changeYear: true,
    changeMonth: true,
    dateFormat: "D, d M, yy"
  )
  $('a[data-toggle="tab"]').on 'click', (e) ->
    e.preventDefault()
    $(this).tab('show');




$(document).on "turbolinks:load cocoon:after-insert", ->
  $('.combo-box').select2(
    theme: "bootstrap",
    selectOnClose: true,
    width: 'resolve'
  );
