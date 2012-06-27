module Etsy

  # = ShopSection
  #
  # Represents a single Etsy shop section.
  #
  # A shop section has the following attributes:
  #
  # [title] The title of the section
  # [rank] Display Order
  # [active_listing_count] The number of active listings in the section

  class ShopSection

    include Etsy::Model

    attributes :title, :active_listing_count, :rank

    attribute :id, :from => :shop_section_id

    # Retrieve one or more shops by name or ID:
    #
    #   Etsy::Shop.find('reagent')
    #
    # You can find multiple shops by passing an array of identifiers:
    #
    #   Etsy::Shop.find(['reagent', 'littletjane'])
    #
    def self.find(*identifiers_and_options)
      self.find_one_or_more('shop_sections', identifiers_and_options)
    end

    def self.find_by_shop_id_and_section_id(shop_id, section_id, options = {})
      self.get_all("/shops/#{shop_id}/sections/#{section_id}", options)
    end

    # Retrieve a list of all shop sections given a shop id.  By default it fetches 25 at a time, but that can
    # be configured by passing the :limit and :offset parameters:
    #
    #   Etsy::ShopSection.all(:limit => 100, :offset => 100)
    #
    def self.all(shop_id, options = {})
      self.get_all("/shops/#{shop_id}/sections", options)
    end
  end
end
