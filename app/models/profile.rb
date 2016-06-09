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

  def self.get_all_profiles(min_birth_year, max_birth_year)
    Profile.where('birth_year BETWEEN :min_birth_year AND :max_birth_year', min_birth_year: min_birth_year, max_birth_year: max_birth_year)
           .order(birth_year: :asc)
  end
end
