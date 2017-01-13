class IndexController < ApplicationController
  def index
    render json: { status: :error, messages: ['root is not support.'] }, status: 404
  end
end
