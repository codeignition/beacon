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
    $('.contact_'+ this.id).remove()

  });
  $('.contact_edit_button').on('click', function(){
    openModal('#edit_contact_modal_' + this.id)
  });
  $('.edit_rule_button').on('click', function(){
    openModal('#edit_rule_modal_' + this.id)
    set_onoffswitch(this.id)
  });


  var addContact = function(_this, added_contacts_class){
    newId = makeId(10)
    contact = _this.selectedOptions[0].text
    if (_this.value != 0){
      current_contacts = $(added_contacts_class).html()
      $(added_contacts_class).html(current_contacts + '<div class="col-md-5 contact_'+ newId +'"><span>'+
        "<select class='level_select'>" + 
        "<option class='level_select' value='1'>Q1</option>"+
        "<option class='level_select' value='2'>Q2</option>" + 
        "<option class='level_select' value='3'>Q3</option>" +
        "<option class='level_select' value='4'>Q4</option>" +
        "<option class='level_select' value='5'>Q5</option>" +
        "<i class='fa fa_arrow float-right'><i></select></span>" +
        "<span class='contact_name' id='" + _this.value + "'>"+ contact + "</span>" +
        "<span class='minus-circle'> <i id='" + newId + "' class='fa fa-minus-circle delete_contact float-right'></i></span></div>")
    }
    _this.value = 0
    $('.delete_contact').on('click', function(){
      $('.contact_'+ this.id).remove()

    });
  }
  $('.add_contact').on('change', function(){
    addContact(this, '.added_contacts')
  });
  $('.add_contact_edit').on('change', function(){

    addContact(this, '#added_contacts_'+ this.id)
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

  var sendRequest = function(url, typeOfRequest,data){
    $.ajax({
      type: typeOfRequest,
      url: url,
      data: data,
      success: function(){
        location.reload()
      },
      dataType: 'json'
    });
  }

  $(".create_group_button").on('click', function(event){
    event.preventDefault()
    form = $('form#'+ this.id)
    edit = this.id.match(/edit_escalation_rule_(\d+)/)
    name = form.find('#escalation_rule_name').val()
    if(edit === null){
      airplane_mode = $('#airplane_mode_switch').prop('checked')
      start_time = $('#start_time_picker').timepicker('getSecondsFromMidnight')
      end_time = $('#end_time_picker').timepicker('getSecondsFromMidnight')
    }
    else{
      er_id = this.id.substring(this.id.length-2, this.id.length)
      airplane_mode = $('#airplane_mode_switch_edit_'+er_id).prop('checked')
      if(airplane_mode==true){
        start_time = $('#start_time_picker_edit_'+er_id).timepicker('getSecondsFromMidnight')
        end_time = $('#end_time_picker_edit_'+er_id).timepicker('getSecondsFromMidnight')
      }
      else{
        start_time=0
        end_time=0
      }
    }
    added_contacts = []
    form.find(".table .col-md-5").each(function(i, el){
      added_contacts.push({
        id: $(el).find('.contact_name')[0].id ,
        level: $(el).find('.level_select').val()
      })
    })
    data = {escalation_rule: {name: name, airplane_mode_on: airplane_mode, airplane_mode_start_time: start_time, airplane_mode_end_time: end_time, contacts: added_contacts}}
    if (edit != null) {
      sendRequest( root_path + "/escalation_rules/" + edit[1], 'PUT', data)
    }else{
      sendRequest( root_path + "/escalation_rules/" , 'POST', data)
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
  if ($('.full_page_scroll').length > 0  ){
  $('.full_page_scroll').fullpage({
    menu: '.annchor-menu',
    anchors: ['landing', 'features#1', 'features#2', 'features#3', 'signin'],
    showActiveTooltips: false,
    slidesNavigation: true,
    slidesNavPosition: 'right',
    afterLoad: function(anchorLink, index){
      activateMenu($("li a[href='#"+ anchorLink +"']").first().parent().first())
      if (anchorLink == 'landing') {
        $('.navbar.fixed img').slideUp()
        $('li.signup').slideUp()
      }else if (anchorLink == 'signin'){ 
        $('.navbar.fixed img').slideUp()
        $('li.signin').slideUp()
        $('li.signup').slideUp()
      }else{
        $('.navbar.fixed img').show()
        $('li.signin').slideDown()
        $('li.signup').slideDown()
      }

    },

  });
  }
  $('.anchor-menu li').on('click', function(){
    activateMenu(this)
  })
  $('.sign-up').on('click', function(event){
    event.preventDefault()
    data = {user: {
      email: $(this).parents('form').find('#user_email').val(),
      password: $(this).parents('form').find('#user_password').val(),
      password_confirmation: $(this).parents('form').find('#user_password_confirmation').val()
    }}
    if (data['user']['password_confirmation'] === data['user']['password']){
      if (data['user']['password'].length >= 8){
        $.ajax({
          type: 'POST',
          url: '/users',
          data: data,
          success: function(){
            window.location.pathname = '/setup/1'
          },
          error: function(){ $('.flash').show();
            $('.flash .message').html('Email Address already exists.')},
          dataType: 'json'
        });  
      }else{
        $('.flash').show();
        $('.flash .message').html('Password must be atleast 8 characters long')
      }
    }else{
      $('.flash').show();
      $('.flash .message').html('Password and password confirmation fields do not match.')
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
      url: '/users/sign_in',
      data: data,
      success: function(){
        window.location.pathname = '/setup/1/'
      },
      error: function(){ $('.flash').show();
        $('.flash .message').html('Email & password combo does not exist.')},
      dataType: 'json'
    });  
  })
  $('.close_flash_button').on('click', function(){
    $('.flash').slideUp()
  })
});


