module APIv2
  class CustomTrades < Grape::API
    helpers ::APIv2::NamedParams

    desc 'Returns trages with ask and bid member'
    params do
      use :market, :trade_filters
    end
    get "/custom-trades" do
      trades = Trade.filter(params[:market], time_to, params[:from], params[:to], params[:limit], order_param)
      present trades, with: APIv2::Entities::CustomTrade
    end
  end
end
