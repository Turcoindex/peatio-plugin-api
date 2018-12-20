module APIv2
  class CustomTrades < Grape::API
    helpers ::APIv2::NamedParams

    desc 'Returns trages with ask and bid member'
    params do
      use :market, :trade_filters
    end
    get "/custom-trades" do
      # trades = Trade.filter(params[:market], time_to, params[:from], params[:to], params[:limit], order_param)
      # present trades, with: APIv2::Entities::CustomTrade
      # trades = Trade.joins('LEFT OUTER JOIN members as ask_member on trades.ask_member_id = ask_member.id').joins('LEFT OUTER JOIN members as bid_member on trades.bid_member_id = bid_member.id').select('trades.*,ask_member.email as ask_member_email, bid_member.email as bid_member_email')
      trades = Trade.joins('LEFT JOIN members as ask_member on trades.ask_member_id = ask_member.id').joins('LEFT JOIN members as bid_member on trades.bid_member_id = bid_member.id').filter(params[:market], time_to, params[:from], params[:to], params[:limit], order_param).select('trades.*,ask_member.email as ask_member_email, bid_member.email as bid_member_email')
      # present trades, with: APIv2::Entities::CustomTrade
    end

    desc 'Returns trages with ask and bid member by grouping test'
    get "/trades-with-grouping" do

#       SELECT ask_member.id, ask_member.email,trade.market_id, SUM(trade.funds) FROM peatio_production.trades AS trade
# LEFT OUTER JOIN peatio_production.members as ask_member on trade.ask_member_id = ask_member.id
# GROUP BY ask_member.id,trade.market_id;
      sql = "SELECT ask_member.id, ask_member.email, SUM(trade.funds) as volume FROM trades AS trade "
      sql += "LEFT OUTER JOIN members as ask_member on trade.ask_member_id = ask_member.id "
      # sql += "WHERE trade.created_at >= '" + params[:startdate] + "' and trade.created_at < '" + params[:enddate] + "' "
      sql += "GROUP BY ask_member.id"

      trades = ActiveRecord::Base.connection.exec_query(sql)
      # present trades, with: APIv2::Entities::TradeWithGrouping
      # trades = Trade.filter(params[:market], time_to, params[:from], params[:to], params[:limit], order_param)
      # trades = Trade.joins('LEFT JOIN members as ask_member on trades.ask_member_id = ask_member.id').joins('LEFT JOIN members as bid_member on trades.bid_member_id = bid_member.id').filter(params[:market], time_to, params[:from], params[:to], params[:limit], order_param).select('trades.*,ask_member.email as ask_member_email, bid_member.email as bid_member_email')
    end
  end
end
