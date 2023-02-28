require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Includes / Extends' do
    it 'includes User made DeviseTokenAuth module' do
      expect(User.included_modules).to include(DeviseTokenAuth::Concerns::User)
    end

    it 'Extends Models made Devise module' do
      expect(User.ancestors).to include(Devise::Models)
    end
  end
end
