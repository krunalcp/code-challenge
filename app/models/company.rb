class Company < ApplicationRecord
  has_rich_text :description

  before_validation :email_validation, :assign_city_and_state

  def email_validation
    return if email.blank? || !email_changed?

    e_message = 'Domain should be getmainstreet.com'
    errors[:email] << e_message unless email.split('@')[1] == 'getmainstreet.com'
  end

  def assign_city_and_state
    return if zip_code.blank? || !zip_code_changed?

    e_message = 'Enter 5 digit ZipCode'
    return errors[:zip_code] << e_message unless zip_code.length == 5

    res = ZipCodes.identify(zip_code)
    e_message = 'Enter Valid ZipCode'
    return errors[:zip_code] << e_message if res.blank?

    self.city = res[:city]
    self.state = res[:state_code]
  end
end
