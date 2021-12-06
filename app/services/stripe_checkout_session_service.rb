class StripeCheckoutSessionService
  def call(event)
    contract= Contract.find_by(checkout_session_id: event.data.object.id)
    contract.update(state: 'paid')
  end
end
