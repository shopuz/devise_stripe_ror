class TodoController < ApplicationController
	before_filter :check_subscription


	def index
		
			@todos = Todo.where(done: false)
			@todone = Todo.where(done: true)
		
		
		
	end

	def new
		@todo = Todo.new
	end

	def create
		@todo = Todo.new(todo_params)

		if @todo.save
			redirect_to todo_index_path, :notice => 'New Item Created'
		else
			render "new"
		end

	end


	def update
		@todo = Todo.find(params[:id])

		if @todo.update_attributes(:done => true)
			redirect_to todo_index_path, :notice => 'Item marked as done'
		else
			redirect_to todo_index_path, :notice => 'Error: item cant be marked as done'
		end

	end

	def destroy
		@todo = Todo.find(params[:id])
		@todo.destroy
		redirect_to todo_index_path, :notice => 'Item successfully deleted'
	end




	private

	def todo_params
		params.require(:todo).permit(:name, :done)
	end

	def check_subscription
		if current_user.subscribed == false
				redirect_to new_subscribe_path, :notice => "first subscribe"
			end

	end
end
