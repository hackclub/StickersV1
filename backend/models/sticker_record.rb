# frozen_string_literal: true

class StickerRecord < AirctiveRecord::Base
  self.base_key = ENV['AIRTABLE_BASE_ID']
  self.table_name = ENV['AIRTABLE_STICKER_DB_TABLE_ID']

  field :name, 'Sticker Name'
  field :image_attachment, 'image_preview'
  field :artist, 'Artist'
  field :event, 'Event'
  field :owned_by, 'owned_by'
  field :allowed, 'permission to show', type: :boolean
  field :event_url, 'event_URL'

  scope :visible, -> { where(allowed: true) }

  def image = image_attachment&.dig(0, "url")

  def as_json(options = nil)
    user_id = options&.dig(:user_id)
    owners = (owned_by || '').split(',').map(&:strip)
    {
      id: id,
      name: name,
      image: posted_URL,
      artist: artist,
      event: event,
      event_URL: event_url,
      owned_by: owned_by,
      owned: user_id && owners.include?(user_id)
    }
  end

  def as_detail_json(options = nil)
    {
      id: id,
      name: name,
      image: image,
      artist: artist,
      event: event,
      event_URL: event_url
    }
  end
end
