class AddressesController < ApplicationController
  before_action :require_authentication

  def index
    @addresses = Current.user.addresses
  end

  def new
    @address = Current.user.addresses.build
  end

  def create
    @address = Current.user.addresses.build(address_params)

    if @address.save
      redirect_to addresses_path,
                  notice: "Address added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @address = Current.user.addresses.find(params[:id])
  end

  def update
    @address = Current.user.addresses.find(params[:id])

    if @address.update(address_params)
      redirect_to addresses_path,
                  notice: "Address updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address = Current.user.addresses.find(params[:id])
    @address.destroy

    redirect_to addresses_path,
                notice: "Address deleted successfully"
  end

  private

  def address_params
    params.require(:address).permit(
      :full_name,
      :phone,
      :address_line_1,
      :address_line_2,
      :city,
      :state,
      :postal_code,
      :country,
      :address_type,
      :default
    )
  end
end