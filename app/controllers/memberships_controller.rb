class MembershipsController < ApplicationController
  def create
    membership = Membership.new(membership_params)
    if membership.save
      render json: membership, status: :created
    else
      render json: { error: membership.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    membership = Membership.find_by(id: params[:id])
    if membership
      membership.destroy
      render json: {}, status: :no_content
    else
      render json: { error: 'Membership not found' }, status: :not_found
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:gym_id, :client_id, :charge)
  end
end
