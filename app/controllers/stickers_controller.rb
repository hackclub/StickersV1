# frozen_string_literal: true

class StickersController < ApplicationController
  def index
    stickers = Airtable::StickerRecord.all.map do |s|
      s.as_json(user_id: current_user&.identifier)
    end

    render inertia: "Stickers", props: {
      stickers: stickers
    }
  end

  def archive
    # Public page - no auth required
    stickers = Airtable::StickerRecord.all.map do |s|
      s.as_json(user_id: nil)
    end

    render inertia: "Archive", props: {
      stickers: stickers
    }
  end

  def show
    authenticate!
    record = Airtable::StickerRecord.find(params[:id])
    if record
      render json: record.as_detail_json
    else
      head :not_found
    end
  end
end
