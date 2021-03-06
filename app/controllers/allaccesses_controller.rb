class AllaccessesController < ApplicationController
  def show
    if Allaccess.exists?(params[:id])
    render locals: {
      allaccess: Allaccess.find(params[:id])
    }
    else
      render html: { message: "404 not found"}, status: 404
    end
  end

  def create
    allaccess = Allaccess.new(allaccess_params)
    allaccess.user = current_user
    if allaccess.save
      redirect_to :back
    else
      flash[:alert] = 'Permission was not given due to errors.'
      redirect_to :back
    end
  end

  def destroy
    allaccess = Allaccess.find(params[:id])
    allaccess.user = current_user
    if allaccess
        allaccess.destroy
        flash[:notice] = 'This user no longer has access to all your lists.'
        redirect_to :back
    else
      flash[:alert] = 'You cannot delete this permission.'
      redirect_to :back
    end
  end
end

private
def allaccess_params
  params.require(:allaccess).permit(:user_id, :assignee_id)
end
