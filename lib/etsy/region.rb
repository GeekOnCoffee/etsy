module Etsy
  class Region
    include Etsy::Model

    attribute :id, :from => :region_id
    attributes :region_name

    def self.find_all
      get("/regions")
    end

    def self.find(id)
      get("/regions/#{id}")
    end
  end
end
