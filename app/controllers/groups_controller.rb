class GroupsController < ApiController
	# before_action :require_login

	def create
		group = current_user.groups.build(group_params)
        if group.save
        	render json: group
        else
        	render json: {"text": "Error in saving group"}, status: 500
        end
	end

	def show
		group = current_user.groups.find(params[:id])
		render json: {group: {name: group.name} }
	end

	def index
		groups = current_user.groups
		render json: groups
	end

	def toggle
		group = current_user.groups.find(params[:group_id])
		group.toggle! :is_active
		render json: group
	end

	def update
      group = current_user.groups.find(params[:id])
      group.update_attributes(group_params)
      render json: group
    end

    def destroy
      group = current_user.groups.find(params[:id])
      if group.destroy
        head :no_content, status: :ok
      else
        render json: group.errors, status: :unprocessable_entity
      end
    end


  private
  def group_params
  	params.require(:group).permit(:name, :description, :is_active, 	:user_id)
  end 
end
