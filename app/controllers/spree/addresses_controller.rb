class Spree::AddressesController < Spree::StoreController
  helper Spree::AddressesHelper

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  load_and_authorize_resource class: 'Spree::Address'
  ssl_required :destroy

  attrs = [:address, :id, :firstname, :lastname, :first_name, :last_name,
           :address1, :address2, :city, :country_id, :state_id,
           :zipcode, :phone, :state_name, :alternative_phone, :company,
           country: [:iso, :name, :iso3, :iso_name],
           state: [:name, :abbr]]

  def show
    redirect_to account_path
  end

  def edit
    session["user_return_to"] = request.env['HTTP_REFERER']
  end

  def new
    @address = Spree::Address.default
  end

  def update
    if @address.editable?
      if @address.update_attributes(address_params)
        flash[:notice] = Spree.t(:successfully_updated, resource: Spree::Address.model_name.human)
        redirect_back_or_default(account_path)
      else
        render :action => "edit"
      end
    else
      new_address            = @address.clone
      new_address.attributes = address_params
      @address.update_attribute(:deleted_at, Time.now)
      if new_address.save
        flash[:notice] = Spree.t(:successfully_updated, resource: Spree::Address.model_name.human)
        redirect_back_or_default(account_path)
      else
        render :action => "edit"
      end
    end
  end

  def create
    @address      = Spree::Address.new(address_params)
    @address.user = spree_current_user
    if @address.save
      flash[:notice] = Spree.t(:successfully_created, resource: Spree::Address.model_name.human)
      redirect_to account_path
    else
      render :action => "new"
    end
  end

  def destroy
    @address.destroy

    flash[:notice] = Spree.t(:successfully_removed, resource: Spree::Address.model_name.human)
    redirect_to(request.env['HTTP_REFERER'] || account_path) unless request.xhr?
  end

  private
  def address_params
    params.require(:address).permit(Spree::PermittedAttributes.address_attributes)
  end
end
