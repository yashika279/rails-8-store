class Address < ApplicationRecord
  belongs_to :user

  validates :full_name,
            :phone,
            :address_line_1,
            :city,
            :state,
            :postal_code,
            presence: true

  enum :address_type,
  {
    home: "home",
    office: "office",
    other: "other"
  }

  before_save :unset_other_defaults,
              if: :default?

  private

  def unset_other_defaults
    user.addresses
        .where.not(id: id)
        .update_all(default: false)
  end
end
