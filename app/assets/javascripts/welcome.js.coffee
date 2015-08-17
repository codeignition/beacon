$( document ).ready(->

  $('#airplane_mode_switch_weekday').prop('checked', false)
  if $('#airplane_mode_switch_weekday').prop('checked') == true
    $('#timepickers_weekday').removeClass 'hide'
  else
    $('#timepickers_weekday').addClass 'hide'

  $('#airplane_mode_switch_weekday').change ->
    if $('#airplane_mode_switch_weekday').prop('checked') == true
      $('#timepickers_weekday').removeClass 'hide'
    else
      $('#timepickers_weekday').addClass 'hide'
    return

  $('#start_time_picker_weekday').timepicker(step:15)
  $('#end_time_picker_weekday').timepicker(step:15)
  $('#start_time_picker_weekday').timepicker('setTime', new Date(2015,1,1,10,0,0))
  $('#end_time_picker_weekday').timepicker('setTime', new Date(2015,1,1,18,0,0))

  $('#airplane_mode_switch_weekend').prop('checked', false)
  if $('#airplane_mode_switch_weekend').prop('checked') == true
    $('#timepickers_weekend').removeClass 'hide'
  else
    $('#timepickers_weekend').addClass 'hide'

  $('#airplane_mode_switch_weekend').change ->
    if $('#airplane_mode_switch_weekend').prop('checked') == true
      $('#timepickers_weekend').removeClass 'hide'
    else
      $('#timepickers_weekend').addClass 'hide'
    return

  $('#start_time_picker_weekend').timepicker(step:15)
  $('#end_time_picker_weekend').timepicker(step:15)
  $('#start_time_picker_weekend').timepicker('setTime', new Date(2015,1,1,10,0,0))
  $('#end_time_picker_weekend').timepicker('setTime', new Date(2015,1,1,18,0,0))

  $('.contact_form input').on('keyup', ->
    redButton = ($('#contact_phone_number').val() != '') * ($('#contact_email_id').val() != '') * ($('#contact_name').val() != '')
    if redButton
      $('.go_to_step_3__button').removeClass('grey')
      $('.go_to_step_3__button').removeAttr('disabled')
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
  $('[data-toggle="tooltip"]').tooltip()

)
