class SessionsController < ApplicationController
  def new

  end

  def create
    # session[:username] = params[:username]
    user = (session[:user_id])? User.find(session[:user_id]) : User.create
    session[:user_id] = user.id
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    session[:room] = (0...9).map { o[rand(o.length)] }.join
    # session[:room] = "room#{rand(10000)}_#{user.id}"
    room = Chat.create(:title => session[:room], :owner_id => user.id)
    room.users << user
    room.save
    relation = room.whitelists.find_by_user_id(user.id)
    relation.approve = true
    relation.save
    session[:room_id] = room.id
    # session[:crypt] = []
    # session[:crypt] << room.id
    redirect_to admin_room_path(room.title)
    # render :text => "Welcome to room #{room.title}!"
  end

  def change_name
    user =  User.find(session[:user_id]) if session[:user_id]
    user.username = params[:username]
    session[:username] = user.username
    user.save
    redirect_to :back
  end

end
