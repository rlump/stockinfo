class StocksController < ApplicationController

  # GET /posts
  # GET /posts.json
  def index

    if (params[:name])
      @stocks = Stock.where('name LIKE ?', "#{params[:name]}%").order(name: :asc)
    else
      @stocks = Stock.all
    end

    # placate ember data's need for a root
    @stocksHash = {}
    @stocksHash["stocks"] = @stocks

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stocksHash }
    end
  end

  def price_history

    if (params[:symbol])
      id = 0
      @price_hist = YahooFinance.historical_quotes(params[:symbol], \
        { start_date: Time::now-(24*60*60*30), end_date: Time::now }). \
        collect {|x|
          pHash = OpenStruct.new(x).marshal_dump
          id += 1 # placate ember data's demand for an id
          pHash[:id] = id
          pHash
        }
    end

    # placate ember data's need for a root
    @priceHash = {}
    @priceHash["prices"] = @price_hist

    respond_to do |format|
      format.html # stock_history.html.erb
      format.json { render json: @priceHash }
    end

  end

end
