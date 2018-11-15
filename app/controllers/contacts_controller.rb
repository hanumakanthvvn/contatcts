class ContactsController < ApiController
	before_action :require_login, :get_group

	def create
		contact = @group.contacts.build(contact_params)
        if contact.save
        	render json: contact
        else
        	render text: "Error in saving contact"
        end
	end

	def show
		contact = @group.contacts.find(params[:id])
		render json: {contact: {name: contact.name} }
	end

	def index
		contacts = @group.contacts
		render json: contacts.to_json
	end

	def update
      contact = @group.contacts.find(params[:id])
      contact.update_attributes(contact_params)
      render json: contact
    end

    def destroy
      contact = @group.contacts.find(params[:id])
      if contact.destroy
        head :no_content, status: :ok
      else
        render json: contact.errors, status: :unprocessable_entity
      end
    end


	def get_group
		@group = current_user.groups.active_groups.find(params[:group_id])
		render head: 500 unless @group
	end

  private
  def contact_params
  	params.require(:contact).permit(:name, :description, :group_id)
  end
end
