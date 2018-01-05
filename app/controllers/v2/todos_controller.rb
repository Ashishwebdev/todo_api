class V2::TodosController < ApplicationController
 def index
   render json: Todo.all
 end
end
