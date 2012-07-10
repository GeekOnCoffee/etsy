module Etsy
  class ShippingInfo
    include Etsy::Model

    attribute :id, :from => :shipping_info_id

    attributes :origin_country_id, :destination_country_id, :listing_id, :region_id, :origin_country_name, :destination_country_name, :primary_cost, :secondary_cost


    def self.find(id, credentials = {})
      options = {
        :access_token => credentials[:access_token],
        :access_secret => credentials[:access_secret],
        :require_secure => true
      }
      get("/shipping/templates/#{id}", options)
    end

    def self.find_by_listing(listing, credentials = {})
      options = {
        :access_token => credentials[:access_token],
        :access_secret => credentials[:access_secret],
        :require_secure => true
      }
      get("/listings/#{listing.id}/shipping/info", options)
    end

    def origin_country
      origin_country_id ? ::Etsy::Country.find(origin_country_id) : nil
    end

    def destination_country
      destination_country_id ? ::Etsy::Country.find(destination_country_id) : nil
    end
  end
end
