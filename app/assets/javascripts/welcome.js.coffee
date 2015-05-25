$( document ).ready(->
  $('.contact_form input').on('keyup', ->
    redButton = ($('#contact_phone_number').val() != '') * ($('#contact_email_id').val() != '') * ($('#contact_name').val() != '')
    if redButton
      $('.go_to_step_3__button').removeClass('grey')
      $('.go_to_step_3__button').removeAttr('disabled');
    else
       $('.go_to_step_3__button').addClass('grey')
       $('.go_to_step_3__button').attr('disabled','disabled')
  )
  $('.go_to_step_3__button').on('click', ->
    data = {name: $('form.edit_organization #organization_name').val()}
    $.ajax(
      type: "PUT"
      url: $('form.edit_organization').attr('action')
      data: data
      dataType: 'json'
    ) 
    $('form.edit_organization').submit()
  )


)
