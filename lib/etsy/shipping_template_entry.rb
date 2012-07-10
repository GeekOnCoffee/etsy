module Etsy
  class ShippingTemplateEntry
    include Etsy::Model

    attribute :id, :from => :shipping_template_entry_id

    attributes :currency_code, :origin_country_id, :destination_country_id, :destination_region_id, :primary_cost, :secondary_cost

    def self.find(shipping_template_id, credentials = {})
      options = {
        :access_token => credentials[:access_token],
        :access_secret => credentials[:access_secret],
        :require_secure => true,
        :limit => 100,
        :offset => 0
      }
      get("/shipping/templates/#{shipping_template_id}/entries", options)
    end

    def origin_country
      origin_country_id ? ::Etsy::Country.find(origin_country_id) : nil
    end

    def destination_country
      destination_country_id ? ::Etsy::Country.find(destination_country_id) : nil
    end

    def destination_region
      destination_region_id ? ::Etsy::Region.find(destination_region_id) : nil
    end
  end
end
