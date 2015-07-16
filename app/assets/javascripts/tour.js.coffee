
$( document ).ready(->  
  tour = new Tour(
    {
      steps: 
        [
          {
            orphan: true
            title: 'Quick Tour'
            content: 'Welcome to Beacon! Take this tour to learn how to use this website and get started on Beacon.'
            backdrop: true
          }
          {
            element: document.querySelector('.org_toggle')
            title: 'Organizations'
            content: 'Use this dropdown to create/edit organization & switch between organizations you belong to.'
            backdrop: true
            placement: 'bottom'
          }
          {
            element: document.querySelector('.alert-link'),
            title: 'Alerts'
            content: 'Recent activity of Beacon call alerts made in this organization will be displayed here. Beacon tracks incident status, queue end-point and IP address.'
            backdrop: true
            placement: 'bottom'
          }
          {
            element: document.querySelector('.settings-link'),
            title: 'Settings'
            content: "Manage current organization's Groups and Team Members, including your account."
            backdrop: true
            placement: 'bottom'
          }
          {
            element: document.querySelectorAll('.tm-table tr')[1],
            title: 'Team Members'
            content: 'You and other team members that you add to your organization will appear here. You can invite as many team members as you wish.'
            backdrop: true
            placement: 'bottom'
          }
          {
            element: document.querySelectorAll('.groups-table tr')[1],
            title: 'Groups'
            content: 'Each Incident has its own Group, with a unique API key & custom calling queues. There is no limit to how many Groups you can create.'
            backdrop: true
            placement: 'bottom'
          }
          {
            orphan: true
            title: 'End Of Tour'
            content: "Test Beacon's hassle-free integration right away. Copy your Group's API Key in your setup, trigger the API & receive your first Beacon call alert."
            backdrop: true
          }
        ]
      onEnd: (tour) ->
        sendRequest( root_path + "/toggle_tour/" , 'GET', null)
        return
    }
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

  tour.init()
  if $('.show_tour').length > 0
    if window.location.pathname != root_path + '/settings'
      window.location.pathname = root_path + '/settings'
    tour.setCurrentStep(0)
    tour.start(true)

)
