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
    return

  $('#start_time_picker').timepicker(step:15)
  $('#end_time_picker').timepicker(step:15)

  er_id = window.er_id
  airplane_mode_switch = document.querySelector('#airplane_mode_switch_edit_'+er_id)
  if er_id!= null && airplane_mode_switch!=null
    if airplane_mode_switch.dataset.er_mode == "true"
      $('#airplane_mode_switch_edit_'+er_id).prop('checked', true)
    else
      $('#airplane_mode_switch_edit_'+er_id).prop('checked', false)

    if $('#airplane_mode_switch_edit_'+er_id).prop('checked') == true
      $('#on_mode_message_edit_'+er_id).removeClass 'hide'
      $('#off_mode_message_edit_'+er_id).addClass 'hide'
      $('#timepickers_edit_'+er_id).removeClass 'hide'
    else
      $('#off_mode_message_edit_'+er_id).removeClass 'hide'
      $('#on_mode_message_edit_'+er_id).addClass 'hide'
      $('#timepickers_edit_'+er_id).addClass 'hide'

    $('#airplane_mode_switch_edit_'+er_id).change ->
      if $('#airplane_mode_switch_edit_'+er_id).prop('checked') == true
        $('#on_mode_message_edit_'+er_id).removeClass('hide')
        $('#off_mode_message_edit_'+er_id).addClass ('hide')
        $('#timepickers_edit_'+er_id).removeClass('hide')
      else
        $('#off_mode_message_edit_'+er_id).removeClass 'hide'
        $('#on_mode_message_edit_'+er_id).addClass 'hide'
        $('#timepickers_edit_'+er_id).addClass('hide')
      return

    start_time_seconds_since_midnight = mode.dataset.er_mode_start_time
    start_time_hours = parseInt(start_time_seconds_since_midnight / 3600)
    start_time_minutes = parseInt((start_time_seconds_since_midnight % 3600) / 60)
    end_time_seconds_since_midnight = mode.dataset.er_mode_end_time
    end_time_hours = parseInt(end_time_seconds_since_midnight / 3600)
    end_time_minutes = parseInt((end_time_seconds_since_midnight % 3600) / 60)
    $('#start_time_picker_edit_'+er_id).timepicker(step:15)
    $('#start_time_picker_edit_'+er_id).timepicker('setTime', new Date(2015, 1, 1, start_time_hours, start_time_minutes,0))
    $('#end_time_picker_edit_'+er_id).timepicker(step:15)
    $('#end_time_picker_edit_'+er_id).timepicker('setTime', new Date(2015, 1, 1, end_time_hours, end_time_minutes,0))

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
