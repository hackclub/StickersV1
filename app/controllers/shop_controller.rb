# frozen_string_literal: true

class ShopController < ApplicationController
  before_action :authenticate!, except: [ :index ]

  def index
    items = begin
      Airtable::ShopRecord.all.map(&:as_json)
    rescue StandardError => e
      Rails.logger.error("Failed to fetch shop items: #{e.message}")
      []
    end

    render inertia: "Shop", props: {
      items: items
    }
  end

  def show
    item = Airtable::ShopRecord.find(params[:id])
    if item
      render json: item.as_json
    else
      head :not_found
    end
  end
end
