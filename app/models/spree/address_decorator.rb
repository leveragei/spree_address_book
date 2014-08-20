Spree::Address.class_eval do
  belongs_to :user, class_name: Spree.user_class.to_s

  Spree::PermittedAttributes.address_attributes << :user_id
  Spree::PermittedAttributes.address_attributes << :deleted_at

  def self.required_fields
    validator = Spree::Address.validators.find { |v| v.kind_of?(ActiveModel::Validations::PresenceValidator) }
    validator ? validator.attributes : []
  end

  # TODO: look into if this is actually needed. I don't want to override methods unless it is really needed
  # can modify an address if it's not been used in an order
  def same_as?(other)
    return false if other.nil?

    #remove nil and empty values from the hash
    current_attributes = clean_hash(attributes.except('id', 'updated_at', 'created_at', 'user_id'))
    other_attributes   = clean_hash(other.attributes.except('id', 'updated_at', 'created_at', 'user_id'))
    current_attributes == other_attributes
  end

  # can modify an address if it's not been used in an completed order
  def editable?
    new_record? || (shipments.empty? && Spree::Order.complete.where("bill_address_id = ? OR ship_address_id = ?", self.id, self.id).count == 0)
  end

  def can_be_deleted?
    shipments.empty? && Spree::Order.where("bill_address_id = ? OR ship_address_id = ?", self.id, self.id).count == 0
  end

  def to_s
    "#{firstname} #{lastname}: #{full_address}, #{city}, #{state || state_name}, #{country}, #{zipcode}"
  end

  def full_address
    [address1, address2].reject(&:blank?).to_a.join(', ')
  end

  # UPGRADE_CHECK if future versions of spree have a custom destroy function, this will break
  def destroy
    if can_be_deleted?
      super
    else
      update_column :deleted_at, Time.now
    end
  end

  private
  def clean_hash(hash)
    hash.delete_if { |k, v| v.nil? || v == "" }
  end

end
