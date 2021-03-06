class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.paginate(:page => params[:page], :per_page => params[:per_page] ||= 10).order(created_at: :desc)
  end

  # GET /users/1 or /users/1.json
  def show
  end



  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user

      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "Sorry, the user that you are looking for cannot be found!"
        respond_to do |format|
          format.html{
            redirect_to users_path
          }

          format.json {render :json , status: 404}
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end
end
