$( document ).ready(->

  $('#airplane_mode_switch').prop('checked', false)
  if $('#airplane_mode_switch').prop('checked') == true
    $('#on_mode_message').removeClass 'hide'
    $('#off_mode_message').addClass 'hide'
    $('#timepickers').removeClass 'hide'
  else
    $('#off_mode_message').removeClass 'hide'
    $('#on_mode_message').addClass 'hide'
    $('#timepickers').addClass 'hide'

  $('#airplane_mode_switch').change ->
    if $('#airplane_mode_switch').prop('checked') == true
      $('#on_mode_message').removeClass 'hide'
      $('#off_mode_message').addClass 'hide'
      $('#timepickers').removeClass 'hide'
    else
      $('#off_mode_message').removeClass 'hide'
      $('#on_mode_message').addClass 'hide'
      $('#timepickers').addClass 'hide'

  $('#start_time_picker').timepicker(step:15)
  $('#end_time_picker').timepicker(step:15)


  mode = document.querySelector('#airplane_mode_switch_edit')
  if mode.dataset.er_mode
    $('#airplane_mode_switch_edit').prop('checked', true)
  else
    $('#airplane_mode_switch_edit').prop('checked', false)

  if $('#airplane_mode_switch_edit').prop('checked') == true
    $('#on_mode_message_edit').removeClass 'hide'
    $('#off_mode_message_edit').addClass 'hide'
    $('#timepickers_edit').removeClass 'hide'
  else
    $('#off_mode_message_edit').removeClass 'hide'
    $('#on_mode_message_edit').addClass 'hide'
    $('#timepickers_edit').addClass 'hide'

  $('#airplane_mode_switch_edit').change ->
    if $('#airplane_mode_switch_edit').prop('checked') == true
      $('#on_mode_message_edit').removeClass 'hide'
      $('#off_mode_message_edit').addClass 'hide'
      $('#timepickers_edit').removeClass 'hide'
    else
      $('#off_mode_message_edit').removeClass 'hide'
      $('#on_mode_message_edit').addClass 'hide'
      $('#timepickers_edit').addClass 'hide'

  start_time_seconds_since_midnight = mode.dataset.er_mode_start_time
  start_time_hours = parseInt(start_time_seconds_since_midnight / 3600)
  start_time_minutes = parseInt((start_time_seconds_since_midnight % 3600) / 60)
  end_time_seconds_since_midnight = mode.dataset.er_mode_end_time
  end_time_hours = parseInt(end_time_seconds_since_midnight / 3600)
  end_time_minutes = parseInt((end_time_seconds_since_midnight % 3600) / 60)
  $('#start_time_picker_edit').timepicker(step:15)
  $('#start_time_picker_edit').timepicker('setTime', new Date(2015, 1, 1, start_time_hours, start_time_minutes,0))
  $('#end_time_picker_edit').timepicker(step:15)
  $('#end_time_picker_edit').timepicker('setTime', new Date(2015, 1, 1, end_time_hours, end_time_minutes,0))

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
