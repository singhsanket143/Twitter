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
    uploaded_file=params[:image]
    filename=SecureRandom.hex+"."+uploaded_file.split('.')[1]
    filepath=Dir.pwd+"/public/uploads/"+filename
    File.open(filepath,'wb') do |file|
      file.write(uploaded_file.read())
    end
    endcurrent_user.profile_picture=filename
    current_user.save!
    return redirect_to '/profile'
  end
end
