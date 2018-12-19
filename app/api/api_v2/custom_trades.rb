module APIv2
  class CustomTrades < Grape::API
    helpers ::APIv2::NamedParams

    desc 'Returns trages with ask and bid member'
    params do
      use :market, :trade_filters
    end
    get "/custom-trades" do
      # trades = Trade.filter(params[:market], time_to, params[:from], params[:to], params[:limit], order_param)
      trades = Trade.joins('LEFT JOIN members as ask_member on trades.ask_member_id = ask_member.id').joins('LEFT JOIN members as bid_member on trades.bid_member_id = bid_member.id').filter(params[:market], time_to, params[:from], params[:to], params[:limit], order_param).select('trades.*,ask_member.email as ask_member_email, bid_member.email as bid_member_email')
      present trades, with: APIv2::Entities::CustomTrade
    end
  end
end
