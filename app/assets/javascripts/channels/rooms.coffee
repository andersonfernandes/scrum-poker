App.room = App.cable.subscriptions.create "RoomsChannel",
  collection: -> $("[data-channel='rooms']")

  connected: ->
    @followCurrentRoom()
    @installPageChangeCallback()

  received: (data) ->
    console.log data
    $(".step-0#{data['step_position']}")
      .find("#user-card-id-#{data['user_id']}")
      .html(data['score']) if @currentUserIsOwnerFromRoom

  followCurrentRoom: ->
    console.log @collection().data('roomId')
    if room_id = @collection().data('roomId')
      @perform 'follow', room_id: room_id 
    else
      @perform 'unfollow'

  currentUserIsOwnerFromRoom: () ->
    @collection().data('ownerRoomId') is parseInt($('meta[name=current-user]').attr('id'))

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on 'turbolinks:load', -> App.room.followCurrentRoom()

