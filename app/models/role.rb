class Role
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,  type: String

  has_and_belongs_to_many :users, class_name: 'User', inverse_of: 'roles'
end
