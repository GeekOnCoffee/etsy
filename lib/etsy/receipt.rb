module Etsy
  class Receipt
    include Etsy::Model

    attribute :id, :from => :receipt_id
    attribute :email, :from => :buyer_email
    attributes :order_id, :seller_user_id, :buyer_user_id, :name, :first_line, :second_line, :city, :state, :zip
    attributes :country_id, :payment_method, :was_paid, :total_tax_cost, :total_price, :total_shipping_cost, :buyer_email
    attributes :subtotal, :grandtotal, :message_from_buyer, :was_shipped, :was_paid, :shipping_tracking_code

    def was_shipped?
      was_shipped
    end

    def was_paid?
      was_paid
    end

    def self.find_all_by_shop(shop_id, options={})
      raise("Secure connection required. Please provide your OAuth credentials via :access_token and :access_secret in the options") if options[:access_token].nil? or options[:access_secret].nil?
      get("/shops/#{shop_id}/receipts", options)
    end

    def buyer(options={})
      get("/users/#{self.buyer_user_id}", options)
    end

    def listings(options={})
      raise("Secure connection required. Please provide your OAuth credentials via :access_token and :access_secret in the options") if options[:access_token].nil? or options[:access_secret].nil?
      Listing.find_all_for_receipt(id, options)
    end

    def transactions(options={})
      raise("Secure connection required. Please provide your OAuth credentials via :access_token and :access_secret in the options") if options[:access_token].nil? or options[:access_secret].nil?
      [Transaction.find_all_by_receipt_id(id, options)].flatten
    end
  end
end