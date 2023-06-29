class ClientsController < ApplicationController
    def index
        clients = Client.all
        render json: clients
    end

    # def show
    #     client = Client.find_by(id: params[:id])
    #     if client
    #       render json: client
    #     else
    #       render json: { error: 'Client not found' }, status: :not_found
    #     end
    # end
    # GET /clients/:id
    def show
        client = Client.find_by(id: params[:id])
        
        if client
        total_amount = client.memberships.sum(:charge)
        render json: { client: client, total_amount: total_amount }
        else
        render json: { error: 'Client not found' }, status: :not_found
        end
    end
   
  def create
    client = Client.new(client_params)
    if client.save
      render json: client, status: :created
    else
      render json: { error: client.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    client = Client.find(params[:id])
    if client.update(client_params)
      render json: client
    else
      render json: {error: client.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    client = Client.find(params[:id])
    client.destroy
    head :no_content
  end

  private

  def client_params
    params.require(:client).permit(:name, :age)
  end
end
