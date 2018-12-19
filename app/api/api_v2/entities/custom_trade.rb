# encoding: UTF-8
# frozen_string_literal: true

module APIv2
  module Entities
    class CustomTrade < Base
      expose :id
      expose :price
      expose :volume
      expose :funds
      expose :ask_member_id, as: :ask_member
      expose :ask_member_email
      expose :bid_member_id, as: :bid_member
      expose :bid_member_email
      expose :market_id, as: :market
      expose :created_at, format_with: :iso8601

      expose :side do |trade, options|
        options[:side] || trade.side
      end
    end
  end
end
