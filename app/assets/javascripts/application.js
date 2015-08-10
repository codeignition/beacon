// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require moment
//= require turbolinks
//= require_tree .

var root_path = ''

var airplane_mode_edit_switch_handle;

airplane_mode_edit_switch_handle = function(er_id) {
  if (!$('#airplane_mode_switch_edit_' + er_id).prop('checked')) {
    change_onoffswitch_state(er_id, true);
  } else {
    change_onoffswitch_state(er_id, false);
  }
};

var set_onoffswitch;

set_onoffswitch = function(er_id) {
  var end_time_hours, end_time_minutes, end_time_seconds_since_midnight, start_time_hours, start_time_minutes, start_time_seconds_since_midnight;
  if ($('#airplane_mode_switch_edit_'+er_id).data('er_mode') == true) {
    $('#airplane_mode_switch_edit_' + er_id).prop('checked', true);
    $('#on_mode_message_edit_' + er_id).removeClass('hide');
    $('#off_mode_message_edit_' + er_id).addClass('hide');
    $('#timepickers_edit_' + er_id).removeClass('hide');
    $('#start_time_picker_edit_' + er_id).timepicker({
      step: 15
    });
    $('#end_time_picker_edit_' + er_id).timepicker({
      step: 15
    });
    start_time_seconds_since_midnight = $('#airplane_mode_switch_edit_'+er_id).data('er_mode_start_time');
    start_time_hours = parseInt(start_time_seconds_since_midnight / 3600);
    start_time_minutes = parseInt(start_time_seconds_since_midnight % 3600 / 60);
    end_time_seconds_since_midnight = $('#airplane_mode_switch_edit_'+er_id).data('er_mode_end_time');
    end_time_hours = parseInt(end_time_seconds_since_midnight / 3600);
    end_time_minutes = parseInt(end_time_seconds_since_midnight % 3600 / 60);
    $('#start_time_picker_edit_' + er_id).timepicker('setTime', new Date(2015, 1, 1, start_time_hours, start_time_minutes, 0));
    $('#end_time_picker_edit_' + er_id).timepicker('setTime', new Date(2015, 1, 1, end_time_hours, end_time_minutes, 0));
  } else {
    $('#airplane_mode_switch_edit_' + er_id).prop('checked', false);
    $('#on_mode_message_edit_' + er_id).addClass('hide');
    $('#off_mode_message_edit_' + er_id).removeClass('hide');
    $('#timepickers_edit_' + er_id).addClass('hide');
  }
};

var change_onoffswitch_state;

change_onoffswitch_state = function(er_id, bool) {
  if (!bool) {
    $('#on_mode_message_edit_' + er_id).removeClass('hide');
    $('#off_mode_message_edit_' + er_id).addClass('hide');
    $('#timepickers_edit_' + er_id).removeClass('hide');
    $('#start_time_picker_edit_' + er_id).timepicker({
      step: 15
    });
    $('#end_time_picker_edit_' + er_id).timepicker({
      step: 15
    });
  } else {
    $('#on_mode_message_edit_' + er_id).addClass('hide');
    $('#off_mode_message_edit_' + er_id).removeClass('hide');
    $('#timepickers_edit_' + er_id).addClass('hide');
  }
};

var menu_icon_click_handle;
menu_icon_click_handle = function(state){
  if(state=='group_up'){
    $('.groups-table').addClass('hide');
    $('#group_menu_up').addClass('hide');
    $('#group_menu_down').removeClass('hide');
  }
  if(state=='group_down'){
    $('.groups-table').removeClass('hide');
    $('#group_menu_up').removeClass('hide');
    $('#group_menu_down').addClass('hide');
  }
  if(state=='team_up'){
    $('.tm-table').addClass('hide');
    $('#team_menu_up').addClass('hide');
    $('#team_menu_down').removeClass('hide');
  }
  if(state=='team_down'){
    $('.tm-table').removeClass('hide');
    $('#team_menu_up').removeClass('hide');
    $('#team_menu_down').addClass('hide');
  }
};

$( document ).ready(function() {
  var makeId = function(n)
  {
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for( var i=0; i < n; i++ )
      text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
  }

  $('.create_rule').on('click', function(){
    openModal('.create_alert_rule')
  });
  $('.create_contact').on('click', function(){
    openModal('.create_contact_modal')
  });
  var openModal = function(klass){
    $(klass).show()
    $(klass).addClass('in',1000, 'ease' )
  }
  var closeModal = function(){
    $('.close_button').parents('.modal.fade').hide()
    $('.close_button').parents('.modal.fade').removeClass('in')
  }
  $('.close_button').on('click', function(){
    closeModal();
  });

  $('.delete_contact').on('click', function(){
    var contact_selector = document.getElementById("select_"+this.id.split('_')[1]);
    var option_to_be_deleted = document.createElement("option");
    option_to_be_deleted.text = document.getElementById("added_contact_"+this.id.split('_')[2]).innerHTML.split('"')[1];
    option_to_be_deleted.value = this.id.split('_')[2]
    contact_selector.add(option_to_be_deleted);
    $('#contact_'+ this.id.split('_')[1] + "_" + this.id.split('_')[2]).remove()
    if($('#added_contacts_'+ this.id.split('_')[1])[0].children.length == 0) $('#select_'+ this.id.split('_')[1])[0].setAttribute('required', 'required')
  });

  $('.contact_edit_button').on('click', function(){
    openModal('#edit_contact_modal_' + this.id)
  });
  $('.edit_rule_button').on('click', function(){
    openModal('#edit_rule_modal_' + this.id)
    set_onoffswitch(this.id)
  });


  var addContact = function(_this, added_contacts_class){
    er_id = added_contacts_class.split('_')[2]
    contact = _this.selectedOptions[0].text
    if (_this.value != ""){
      current_contacts = $(added_contacts_class).html()
      $(added_contacts_class).html(current_contacts + '<div class="col-md-5 contact_'+ er_id + '_' + _this.value +'"><span>'+
        "<select class='level_select'>" + 
        "<option class='level_select' value='1'>Q1</option>"+
        "<option class='level_select' value='2'>Q2</option>" + 
        "<option class='level_select' value='3'>Q3</option>" +
        "<option class='level_select' value='4'>Q4</option>" +
        "<option class='level_select' value='5'>Q5</option>" +
        "<i class='fa fa_arrow float-right'><i></select></span>" +
        "<span class='contact_name' id='added_contact_" + _this.value + "'>"+ contact + "</span>" +
        "<span class='minus-circle'> <i id='circle_" + er_id + '_' + _this.value + "' class='fa fa-minus-circle delete_contact float-right'></i></span></div>")
      if(added_contacts_class.split('_').length==3){
        $('#select_'+added_contacts_class.split('_')[2]+ ' option:selected').remove()
        $('#select_'+added_contacts_class.split('_')[2]).removeAttr('required')
      }
      else{
        $('.add_contact option:selected').remove()
        $('.add_contact').removeAttr('required');
      }
    }
    _this.value = ""
    $('.delete_contact').on('click', function(){
      if(added_contacts_class.split('_').length == 3){
        var contact_selector = document.getElementById("select_"+added_contacts_class.split('_')[2]);
      }
      else{
        var contact_selector = $('.add_contact')[0];
      }
      var option_to_be_deleted = document.createElement("option");
      option_to_be_deleted.text = document.getElementById("added_contact_"+this.id.split('_')[2]).innerHTML;
      option_to_be_deleted.value = this.id.split('_')[2]
      contact_selector.add(option_to_be_deleted);
      $('.contact_'+ this.id.split('_')[1] + '_' + this.id.split('_')[2]).remove()
      if(added_contacts_class.split('_').length==3){
        if($('#added_contacts_'+added_contacts_class.split('_')[2])[0].children.length == 0) $('#select_'+added_contacts_class.split('_')[2])[0].setAttribute('required', 'required')
      }
      else{
        if($('.added_contacts')[0].children.length == 0) $('.add_contact')[0].setAttribute('required', 'required')
      }
    });
  }

  $('.add_contact').on('change', function(){
    addContact(this, '.added_contacts')
  });
  $('.add_contact_edit').on('change', function(){
    addContact(this, '#added_contacts_'+ this.id.split('_')[1])
  });
  var create_escalation_rule = function(data){
    $.ajax({
      type: "POST",
      url: "/escalation_rules/",
      data: data,
      success: function(){
        location.reload()
      },
      dataType: 'json'
    });
  }

  var sendRequest = function(url, typeOfRequest,data, form_id){
    $.ajax({
      type: typeOfRequest,
      url: url,
      data: data,
      success: function(){
        location.reload()
      },
      error: function(xhr){
        setFormErrors(xhr.responseText, form_id)
      },
      dataType: 'json'
    });
  }

  var setFormErrors = function(errors, form_id){
    var error_keys = Object.keys(errors)
    $('#errors_'+form_id).append(errors)
  }

  $('[id*="escalation_rule"]').on('submit', function(event){
    event.preventDefault()
    form = $('form#'+ this.id)
    edit = this.id.match(/edit_escalation_rule_(\d+)/)
    name = form.find('#escalation_rule_name').val()
    if(edit === null){
      airplane_mode = $('#airplane_mode_switch').prop('checked')
      if(airplane_mode==true){
        start_time = $('#start_time_picker').timepicker('getSecondsFromMidnight')
        end_time = $('#end_time_picker').timepicker('getSecondsFromMidnight')
      }
      else{
        start_time = 0
        end_time = 0
      }
    }
    else{
      er_id = this.id.split('_')[3]
      airplane_mode = $('#airplane_mode_switch_edit_'+er_id).prop('checked')
      if(airplane_mode==true){
        start_time = $('#start_time_picker_edit_'+er_id).timepicker('getSecondsFromMidnight')
        end_time = $('#end_time_picker_edit_'+er_id).timepicker('getSecondsFromMidnight')
      }
      else{
        start_time = 0
        end_time = 0
      }
    }
    added_contacts = []
    form.find(".table .col-md-5").each(function(i, el){
      added_contacts.push({
        id: $(el).find('.contact_name')[0].id.split('_')[2] ,
        level: $(el).find('.level_select').val()
      })
    })
    data = {escalation_rule: {name: name, airplane_mode_on: airplane_mode, airplane_mode_start_time: start_time, airplane_mode_end_time: end_time, contacts: added_contacts}}
    if (edit != null) {
      sendRequest( root_path + "/escalation_rules/" + edit[1], 'PUT', data, this.id)
    }else{
      sendRequest( root_path + "/escalation_rules/" , 'POST', data, this.id)
    }
  })

   $(".create_org_button").on('click', function(event){
    event.preventDefault()
    form = $('form#'+ this.id)
    name = form.find('#organization_name').val()
    data = {organization: {name: name}}
    edit = this.id.match(/edit_organization_(\d+)/)
    if (edit != null) {
      sendRequest( root_path + "/organizations/" + edit[1], 'PUT', data)
    }else{
      sendRequest( root_path + "/organizations/" , 'POST', data)
    }
  }) 

  $('.cancel_delete').on('click', function(event){
   event.preventDefault()
   $(this).parents('.modal-footer').children('.confirmation').slideUp()
   $(this).parents('.modal-footer').find('.edit_actions').slideDown()   
 })
  $('.show_confirmation').on('click', function(event){
   event.preventDefault()
   $(this).parents('.modal-footer').children('.confirmation').slideDown()
   $(this).parents('.col-md-4').children('.edit_actions').slideUp()   
 })
  $(".delete_escalation_rule").on('click', function(event){
    event.preventDefault()
    id = this.id.match(/delete_escalation_rule_(\d+)/)
    sendRequest( root_path + "/escalation_rules/" + id[1], 'DELETE', null)
 }) 

  $(".delete_org").on('click', function(event){
    event.preventDefault()
    id = this.id.match(/delete_org_(\d+)/)
    sendRequest( root_path + "/organizations/" + id[1], 'DELETE', null)
 }) 
  $('.org_toggle').on('mouseover', function(){
    hoverShow(this)
  })
  $('.org_toggle').on('mouseout', function(){
    hoverShow(this)
  })
  var hoverShow = function(_this){
    if ($('.org_menu').hasClass('active')){
      $('.org_menu').removeClass('active')
      $(_this).parents('.nav').removeClass('org_active')
    }else{
      $('.org_menu').addClass('active')
      $(_this).parents('.nav').addClass('org_active')
    }
  }

  $('.edit_org').on('click', function(){
    openModal('#edit_org_modal_' + this.id)
  })
   $('.create_org_event').on('click', function(){
    openModal('#create_org_modal')
  })

  $('.org_menu li .col-md-8').on('click', function(){
    data = {id: $(this).attr('id')}
    sendRequest( root_path + "/set_org/", 'POST', data)
  })
  var activateMenu = function(_this){
    $(_this).siblings().each(function(i, el){
      $(el).removeClass('active')
    })
    $(_this).addClass('active')
  }

  $('.anchor-menu li').on('click', function(){
    activateMenu(this)
  })

  $('.sign-up').on('click', function(event){
    console.log('In sign up');
    event.preventDefault()
    data = {user: {
      email: $(this).parents('form').find('#user_email').val(),
      password: $(this).parents('form').find('#user_password').val(),
      password_confirmation: $(this).parents('form').find('#user_password_confirmation').val()
    }}
    var emailReg = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

    if( emailReg.test(data['user']['email']) && data['user']['email'].length > 0){
      $('#user_email').removeClass('error');
      $('#email_error_message').addClass('hide');

      if (data['user']['password_confirmation'] === data['user']['password']){
        $('#confirm_password_error_message').addClass('hide');

        if (data['user']['password'].length >= 8){
          $('#password_error_message').addClass('hide');
          $.ajax({
            type: 'POST',
            url: '/users',
            data: data,
            success: function(){
              window.location.pathname = '/setup/1'
            },
            error: function(xhr){
              xhr = JSON.parse(xhr.responseText)
              if(xhr.errors.sign_in_count=="User exists but never Signed in!"){
                window.location = '/users/password/new?login='+xhr.errors.email_id
              }else{
                var error_message = document.createElement('div');
                error_message.innerHTML = 'Email Address already exists.';
                error_message.setAttribute('id', 'user_exists_error_message');
                $('#user_email').addClass('error');
                $('#user_email').parent()[0].appendChild(error_message);
                $('#user_exists_error_message').addClass('error-message');
                $('#user_exists_error_message').addClass('align-center');
                $('#user_exists_error_message').addClass('min-padding');
              }
            },
            dataType: 'json'
          });
        }
        else{
          var error_message = document.createElement('div');
          error_message.innerHTML = 'Password must be at least 8 characters long.';
          error_message.setAttribute('id', 'password_error_message');
          $('#user_password').parent().parent()[0].appendChild(error_message);
          $('#password_error_message').addClass('error-message');
          $('#password_error_message').addClass('align-center');
          $('#password_error_message').addClass('min-padding');
        }
      }
      else{
        var error_message = document.createElement('div');
        error_message.innerHTML = 'Password and password confirmation fields do not match.';
        error_message.setAttribute('id', 'confirm_password_error_message');
        $('#user_password').parent().parent()[0].appendChild(error_message);
        $('#confirm_password_error_message').addClass('error-message');
        $('#confirm_password_error_message').addClass('align-center');
        $('#confirm_password_error_message').addClass('min-padding');
      }
    }
    else{
      if(!$('#user_email').hasClass('error')){
        $('#user_email').addClass('error');
        var error_message = document.createElement('div');
        error_message.innerHTML = 'Enter valid email address';
        error_message.setAttribute('id', 'email_error_message');
        $('#user_email').parent()[0].appendChild(error_message);
        $('#email_error_message').addClass('error-message');
        $('#email_error_message').addClass('align-center');
        $('#email_error_message').addClass('min-padding');
      }
    }
  })
  $('.sign-in').on('click', function(event){
    event.preventDefault()
    data = {user: {
      login: $(this).parents('form').find('#user_login').val(),
      password: $(this).parents('form').find('#user_password').val()
    }}
    $.ajax({
      type: 'POST',
      url: '/users/sign_in.json',
      data: data,
      success: function(){
        window.location.pathname = '/setup/1/'
      },
      error: function(){
        if(!$('#user_login').hasClass('error')){
          $('#user_login').addClass('error');
          var error_message = document.createElement('div');
          error_message.innerHTML = 'Email & password combo does not exist.';
          error_message.setAttribute('id', 'login_error_message');
          $('#login_password_field').parent()[0].appendChild(error_message);
          $('#login_error_message').addClass('error-message');
          $('#login_error_message').addClass('align-center');
        }
      },
      dataType: 'json'
    });
  })

  $('.close_flash_button').on('click', function(){
    $('.flash').slideUp()
  })

});


