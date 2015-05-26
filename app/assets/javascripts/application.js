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

var root_path = '/beacon'
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
        "</select></span>" +
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
    name = form.find('#escalation_rule_name').val()
    added_contacts = []
    form.find(".table .col-md-5").each(function(i, el){
      added_contacts.push({
        id: $(el).find('.contact_name')[0].id ,
        level: $(el).find('.level_select').val()
      })

    })
    data = {escalation_rule: {name: name, contacts: added_contacts}}
    edit = this.id.match(/edit_escalation_rule_(\d+)/)
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
});


