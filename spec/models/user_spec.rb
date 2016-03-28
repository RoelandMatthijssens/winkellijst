require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @enermis = User.create!(email: 'enermis@fulgens.com', password: 'somepass')
  end

end
