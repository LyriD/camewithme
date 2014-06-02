class ChatsController < ApplicationController
  def room
    chat = Chat.find_by_title(params[:room_hash])
    Rails.logger.info "-----|||||----> #{chat.id}"
    @chat = chat
    if session[:user_id]
      user = User.find(session[:user_id])
        if chat.user.id == session[:user_id] or (chat.whitelists.find_by_user_id(user.id) and chat.whitelists.find_by_user_id(user.id).approve)    #если пользователя пустили либо он создатель

          #приступаем к чату

        else  #если нет доступа

          if chat.users.include?(user)
              relation = chat.whitelists.find_by_user_id(user.id)
            else
              chat.users << user   #добавляем пользователя в чат
              relation = chat.whitelists.find_by_user_id(user.id)
              relation.approve = false                       #делаем его неподтвержденным в чате
              o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
              relation.salt = (0...7).map { o[rand(o.length)] }.join         #генерим соль


              # PrivatePub.publish_to("/add_user/#{chat.title}", "alert('к вам добавился #{relation.salt}')")

              PrivatePub.publish_to("/add_user/#{chat.title}/#{chat.owner_id}", "alert('к вам добавился #{relation.salt}'); location.reload();")



              Rails.logger.info "--------> #{relation.salt }"
              relation.save
          end
          @salt = relation.salt
          render 'get_salt'
          #рисуем соль
        end
    else

      user = User.create()
      session[:user_id] = user.id
      chat.users << user   #добавляем пользователя в чат
      relation = chat.whitelists.find_by_user_id(user.id)
      relation.approve = false                       #делаем его неподтвержденным в чате
      o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      relation.salt = (0...7).map { o[rand(o.length)] }.join          #генерим соль

      PrivatePub.publish_to("/add_user/#{chat.title}/#{chat.owner_id}", "alert('к вам добавился #{relation.salt}'); location.reload();")





      relation.save
      @salt = relation.salt
      render 'get_salt'
      #генерим соль для доступа

    end




    # redirect_to '/login' unless session[:username]
    room = Chat.find_by_title(params[:room_hash])
    # @messages = Message.where(:room_id => room.id)
  end

  def index

  end

  def admin
     @chat = Chat.find_by_title(params[:room_hash])
  end

  def update_room
    chat = Chat.find_by_title(params[:some_data])
    @send = true
    @chat = chat
    params[:to_delete].each do |id|
      relation = chat.whitelists.find_by_user_id(id)
      relation.approve = false
      relation.save
      PrivatePub.publish_to("/approved_for_room/#{chat.title}/#{id.first}", "alert('Вас удалили из комнаты'); window.location.href = 'http://stackoverflow.com'")
    end unless params[:to_delete].nil?
    params[:to_accept].each do |id|
      relation = chat.whitelists.find_by_user_id(id)
      relation.approve = true
      relation.save
      PrivatePub.publish_to("/approved_for_room/#{chat.title}/#{id.first}", "alert('Вас добавили в комнату'); location.reload();")
    end unless params[:to_accept].nil?

    # PrivatePub.publish_to "/approved_for_room/#{chat.title}" do
    # "$('.site-wrapper').html('j render 'room', locals: {send: true}');"
    # end
    redirect_to :back
  end


  def approve
    chat = Chat.find(params[:room_id])
    relation = chat.whitelists.find_by_user_id(params[:user_id])
    relation.approve = true
    relation.save
    @send = true
    @chat = chat
  end

  def get_out
    chat = Chat.find(params[:room_id])
    relation = chat.whitelists.find_by_user_id(params[:user_id])
    relation.approve = false
    relation.save
  end

end
