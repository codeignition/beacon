
$( document ).ready(->  
  intro = introJs()
  intro.setOptions(
    skipLabel: "<i class='fa fa-times'></i>"
    nextLabel: "<div class='font-normal teal'>NEXT</div>"
    prevLabel: "<div class='font-normal'>BACK</div>"
    doneLabel: "<div class='font-normal'>DONE</div>"
    exitOnOverlayClick: false
    showStepNumbers: false
    showBullets: false
    highlightClass: 'highlighted-class'
  )
  intro.setOptions(
    steps: [
      { 
        intro: "<h3 class='font-normal'>Quick Tour</h3> 
          <p>
            Welcome to Beacon! Take this tour to learn how to use this website and get started on Beacon.
          </p>
        "
        
      }
      {
        element: document.querySelector('.org_toggle'),
        intro: "<h3 class='font-normal'>Organizations</h3> 
          <p>
           Use this dropdown to create/edit organization & switch between organizations you belong to. 
          </p>
        "
      }
      {
        element: document.querySelector('.alert-link'),
        intro: "<h3 class='font-normal'>Alerts</h3> 
          <p>
           Recent activity of Beacon call alerts made in this organization will be displayed here.
           Beacon tracks incident status, queue end-point and IP address 
          </p>
        "
      }
      {
        element: document.querySelector('.settings-link'),
        intro: "<h3 class='font-normal'>Settings</h3> 
          <p>
           Manage current organization's Groups and Team Members, including your account.  
          </p>
        "
      }
      {
        element: document.querySelectorAll('.tm-table tr')[1],
        intro: "<h3 class='font-normal'>Team Members</h3> 
          <p>
           You and other team members that you add to your organization will appear here.
           You can invite as many team members as you wish.  
          </p>
        "
      }
      {
        element: document.querySelectorAll('.groups-table tr')[1],
        intro: "<h3 class='font-normal'>Groups</h3> 
          <p>
           Each Incident has its own Group, with a unique API key & custom calling queues.
           There is no limit to how many Groups you can create. 
          </p>
        "
      }
      {
        intro: "<h3 class='font-normal'>End Of Tour</h3> 
          <p>
           Test Beacon's hassle-free integration right away.
           Copy your Group's API Key in your setup, trigger the API & receive your first Beacon call alert.  
          </p>
        "
      }
    ]
  )
  
  sendRequest = (url, typeOfRequest,data)->
    $.ajax(
      type: typeOfRequest
      url: url
      data: data
      success: ->
        location.reload()
      
      dataType: 'json'
    )  
  $('.take_tour').on('click', ->
    sendRequest( root_path + "/toggle_tour/" , 'GET', null)
  ) 
  intro.oncomplete(->
    sendRequest( root_path + "/toggle_tour/" , 'GET', null)
  )
  intro.onexit(->
    sendRequest( root_path + "/toggle_tour/" , 'GET', null)
  )
  intro.onafterchange((targetElement)->
    if intro._currentStep == 0
      $('.introjs-tooltipbuttons .introjs-prevbutton').hide()
    else if intro._currentStep == (intro._introItems.length - 1)
      $('.introjs-tooltipbuttons .introjs-prevbutton').show()
      $('.introjs-tooltipbuttons .introjs-nextbutton').hide()
      $('.introjs-tooltipbuttons .introjs-skipbutton').addClass('introjs-donebutton')
      $('.introjs-tooltipbuttons .introjs-skipbutton').removeClass('introjs-skipbutton')
    else
      $('.introjs-tooltipbuttons .introjs-prevbutton').show()
      $('.introjs-tooltipbuttons .introjs-donebutton').addClass('introjs-skipbutton')
      $('.introjs-tooltipbuttons .introjs-donebutton').removeClass('introjs-donebutton')
      $('.introjs-tooltipbuttons .introjs-nextbutton').show()

  )
  if $('.show_tour').length > 0
    if window.location.pathname != root_path + '/settings'
      window.location.pathname = root_path + '/settings'
    intro.start()

)
