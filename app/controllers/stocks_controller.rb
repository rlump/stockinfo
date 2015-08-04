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

  def price_history

    if (params[:symbol])
      @price_hist = YahooFinance.historical_quotes(params[:symbol], { start_date: Time::now-(24*60*60*30), end_date: Time::now })
      @price_hist = @price_hist.collect {|x| OpenStruct.new(x).marshal_dump }
    end

    respond_to do |format|
      format.html # stock_history.html.erb
      format.json { render json: @price_hist }
    end

  end

  def price_history_avg

    if (params[:symbol])
      @price_hist = YahooFinance.historical_quotes(params[:symbol], { start_date: Time::now-(24*60*60*30), end_date: Time::now })
      @price_hist = @price_hist.collect {|x| OpenStruct.new(x).marshal_dump }
      @price_avg = @price_hist.map {|x| (x[:high].to_f+x[:low].to_f+x[:open].to_f+x[:close].to_f)/4 }
    end

    respond_to do |format|
      format.html # stock_history.html.erb
      format.json { render json: @price_avg }
    end

  end

end
