class TimeGreaterThanOrEqualToValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    other_value = record.public_send(options.fetch(:with))
    return if value.blank? || other_value.blank?
    if value < other_value
      record.errors[attribute] << (options[:message] || "must be greater than start time")
    end
  end
end
