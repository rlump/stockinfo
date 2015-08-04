class StocksController < ApplicationController

  # GET /posts
  # GET /posts.json
  def index

    if (params[:name])
      @stocks = Stock.where('name LIKE ?', "#{params[:name]}%")
    else
      @stocks = Stock.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stocks }
    end
  end

end
