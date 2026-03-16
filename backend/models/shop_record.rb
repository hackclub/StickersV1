# frozen_string_literal: true

class ShopRecord < AirctiveRecord::Base
  self.base_key = ENV['AIRTABLE_BASE_ID']
  self.table_name = ENV['AIRTABLE_SHOP_TABLE_ID']

  field :name, 'Sticker Name'
  field :image, 'posted_URL'
  field :price, 'Cost'
  field :description, 'Description'

  def as_json(_options = nil)
    {
      id: id,
      name: name,
      image: image,
      price: price,
      description: description
    }
  end
end
