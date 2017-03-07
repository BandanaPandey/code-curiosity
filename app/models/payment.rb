class Payment
  include Mongoid::Document
  
  field :amount, type: Integer, default: 0
  field :status, type: String
  field :transaction_id, type: String
  field :transaction_date, type: Time
  
  validates :status, inclusion: { in: %w(success failure) }
  
  belongs_to :sponser_payment, polymorphic: true
end
