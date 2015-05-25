class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :levels
  belongs_to :organization


  before_destroy { |record| Level.destroy_all "contact_id = #{record.id}"   }
  def unverified?
    self.confirmed_at ? false : true
  end
end
