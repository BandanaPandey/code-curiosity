class Payment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :amount, type: Integer, default: 0
  field :status, type: String
  field :type, type: String
  field :transaction_id, type: String
  field :transaction_date, type: Time
  field :currency, type: String
  field :customer_id, type: String
  field :description, type: String
  field :subscription_id, type: String
  field :valid_until, type: Date
  #validates :status, inclusion: { in: %w(success failure) }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  
  belongs_to :paymentable, polymorphic: true
end
