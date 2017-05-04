module PaymentHelper
  def create_stripe_customer(email, token)
    Stripe::Customer.create(
      email: email,
      source: token
      )
  end

  def create_customer_charge(customer, amount, description, currency)
    Stripe::Charge.create(
      customer: customer.id,
      amount: amount,
      description: description,
      currency: currency
      )
  end
end