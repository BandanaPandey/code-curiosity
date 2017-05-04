class PaymentsController < ApplicationController
  include PaymentHelper
  #before_action :authenticate_user!
  #before_action :authenticate_sponsorer!
  
  def new
    render layout: 'sponser'
  end

  def create
    @amount = params[:amount].gsub('$', '').gsub(',', '')

    @amount = (Float(@amount).round(2) * 100).to_i

    user = current_user ? current_user : current_sponsorer
    
    customer = create_stripe_customer(user.email, params[:stripeToken])
    
    customer_charge = create_customer_charge(customer, @amount, 'one time payment', 'usd')

    @payment = user.payments.build({
                amount: (customer_charge.amount/100).to_i,
                currency: customer_charge.currency,
                customer_id: customer.id,
                description: customer_charge.description}
                )

    if @payment.save
      flash[:notice] = 'Payment done successfully'
      redirect_to sponsorers_path and return
    end
  end

  private
  
  def create_stripe_payment_with_email
    @payment = Payment.create(
      amount: (params[:amount]/100).to_i,
      card: params[:stripeToken],
      currency: 'usd',
      customer_id: @customer.id,
      description: 'one time payment',
      email: params[:stripeEmail]
    )
  end
end