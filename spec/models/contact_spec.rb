require 'rails_helper'
RSpec.describe Contact, :type => :model do

it { should have_many(:levels) }
it { should belong_to(:user) }
end
