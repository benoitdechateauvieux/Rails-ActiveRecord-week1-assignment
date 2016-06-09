class Profile < ActiveRecord::Base
  belongs_to :user

  def validate_nullity_of_first_name_and_last_name
  	errors.add(:first_name, 'first_name and last_name cannot be null at the same time') if (first_name.nil? && last_name.nil?)
  end

  def validate_male_cannot_have_first_name_Sue
  	errors.add(:first_name, 'first_name cannot be Sue for males') if (first_name == 'Sue' && gender=='male')
  end

  validate :validate_nullity_of_first_name_and_last_name
  validates :gender, inclusion: {in: ['male', 'female']}
  validate :validate_male_cannot_have_first_name_Sue
end
