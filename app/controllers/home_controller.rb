class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweet=Tweet.new
  end

  def users
    @users=User.all
  end

  def follow
    followee_id=params[:followee_id]
    if current_user.can_follow followee_id
      FollowMapping.create(:followee_id => followee_id,:follower_id => current_user.id)
    end
    return redirect_to '/users'
  end

  def un_follow
    followee_id=params[:followee_id]
    if current_user.can_un_follow followee_id
      FollowMapping.where(:followee_id=>followee_id,:follower_id=>current_user.id).first.destroy
    end
    return redirect_to '/users'
  end

  def profile
  end
  def upload_image
  end
end
