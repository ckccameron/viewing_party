class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(email: params[:friend_email])
    if friend
      Friendship.create_friendships_reciprocal(current_user.id, friend.id)
      flash[:success] = "#{friend.name} has been added"
    else
      flash[:error] = "Couldn't find user with this email: #{params[:friend_email]}"
    end
    redirect_to dashboard_path
  end
end
