# frozen_string_literal: true

module Airtable
  class StickerRecord < AirctiveRecord::Base
    self.base_key = ENV["AIRTABLE_BASE_ID"]
    self.table_name = ENV["AIRTABLE_STICKER_DB_TABLE_ID"]

    field :name, "Sticker Name"
    field :image, "posted_URL"
    field :artist, "Artist"
    field :event, "Event"
    field :owned_by, "owned_by"
    field :allowed, "permission to show", type: :boolean
    field :exists, "img exists", type: :boolean
    field :event_url, "event_URL"
    field :tags, "Tags"

    scope :visible, -> { where(allowed: true, exists: true) }

    def as_json(options = nil)
      user_id = options&.dig(:user_id)
      owners = (owned_by || "").split(",").map(&:strip)
      {
        id: id,
        name: name,
        image: image,
        artist: artist,
        event: event,
        event_url: event_url,
        tags: parse_tags,
        owned: user_id && owners.include?(user_id)
      }
    end

    def as_detail_json(_options = nil)
      {
        id: id,
        name: name,
        image: image,
        artist: artist,
        event: event,
        event_url: event_url,
        tags: parse_tags
      }
    end

    private

    def parse_tags
      return [] unless tags
      tags.is_a?(Array) ? tags : tags.to_s.split(",").map(&:strip)
    end
  end
end
