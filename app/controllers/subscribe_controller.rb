class SubscribeController < ApplicationController
	before_filter :authenticate_user!

	def new
		
	end

	def update
		# get credit card details
		token = params[:stripeToken]

		# create customer
		customer = Stripe::Customer.create(
			:card => token,
			:plan => 111,
			:email => current_user.email

			)

		current_user.subscribed = true
		current_user.stripeid = customer.id
		current_user.save

		redirect_to todo_index_path, :notice => 'Subscription successfully setup'
	end

end
