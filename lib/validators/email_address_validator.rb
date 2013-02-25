class EmailAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.blank?
      valid = value.match /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/
      record.errors[attribute] << 'must be a valid email address' unless valid
    end
  end
end
