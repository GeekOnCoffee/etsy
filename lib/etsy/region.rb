module Etsy
  class Region
    include Etsy::Model

    attribute :id, :from => :region_id
    attributes :region_name

    def self.find_all(options)
      get("/regions", options)
    end

    def self.find(id, options)
      get("/regions/#{id}", options)
    end
  end
end
