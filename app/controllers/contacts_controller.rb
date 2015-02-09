class ContactsController < ApplicationController
  def index
    contacts = Contact.joins("LEFT OUTER JOIN contact_shares
                      ON contact_shares.contact_id = contacts.id")
                      .where("contact_shares.user_id = :id
                      OR contacts.user_id = :id", id: params[:user_id]).uniq
    render json: contacts
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    contact = Contact.find(params[:id])
    render json: contact
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy!
    render json: contact
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
