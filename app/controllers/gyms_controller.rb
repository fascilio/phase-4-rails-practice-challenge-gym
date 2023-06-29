class GymsController < ApplicationController
    def index
        gyms = Gym.all
        render json: gyms
    end
    
  def show
    gym = Gym.find_by(id: params[:id])
    if gym
      render json: gym
    else
      render json: { error: 'Gym not found' }, status: :not_found
    end
  end

  def create
    gym = Gym.new(gym_params)
    if gym.save
      render json: gym, status: :created
    else
      render json: { error: gym.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    gym = Gym.find(params[:id])
    if gym.update(gym_params)
      render json: gym
    else
      render json: {error: gym.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    gym = Gym.find_by(id: params[:id])
    if gym
      gym.destroy
      render json: {}, status: :no_content
    else
      render json: { error: 'Gym not found' }, status: :not_found
    end
  end

  private

  def gym_params
    params.require(:gym).permit(:name, :address)
  end
end
