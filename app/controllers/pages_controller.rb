# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate!, only: [ :dashboard, :trade, :designs ]

  def index
    # Redirect to dashboard if already logged in
    if logged_in?
      redirect_to "/dash"
    else
      render inertia: "Landing"
    end
  end

  def dashboard
    render inertia: "Dashboard"
  end

  def trade
    render inertia: "Trade"
  end

  def designs
    designs = begin
      Airtable::StickerRecord.all.map do |s|
        {
          id: s.id,
          name: s.name,
          image: s.image,
          artist: s.artist,
          in_stock: nil, # TODO: Add stock tracking
          price: nil,    # TODO: Add pricing
          program: s.event,
          created: nil
        }
      end
    rescue StandardError => e
      Rails.logger.error("Failed to fetch designs: #{e.message}")
      []
    end

    render inertia: "Designs", props: {
      designs: designs
    }
  end

  def error_page
    render inertia: "Error"
  end

  def placeholder
    render inertia: "Placeholder", props: {
      page: request.path.delete_prefix("/")
    }
  end
end
