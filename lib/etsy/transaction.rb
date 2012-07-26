module Etsy
  class Transaction
    include Model

    attribute :id, :from => :transaction_id
    attribute :buyer_id, :from => :buyer_user_id
    attributes :quantity, :listing_id, :price

    def self.find_all_by_shop_id(shop_id, options = {})
      raise("Secure connection required. Please provide your OAuth credentials via :access_token and :access_secret in the options") if options[:access_token].nil? or options[:access_secret].nil?
      get_all("/shops/#{shop_id}/transactions", options)
    end

    def self.find_all_by_receipt_id(receipt_id, options = {})
      get("/receipts/#{receipt_id}/transactions", options)
    end

    def buyer
      @buyer ||= User.find(buyer_id)
    end

  end
end