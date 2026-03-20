# frozen_string_literal: true

class DesignsController < ApplicationController
  before_action :authenticate!, except: [ :all ]

  # GET /my-designs - user's own designs
  def index
    designs = Airtable::Design.by_user(current_user.identifier).all.map do |d|
      d.as_json(user_id: current_user.identifier)
    end

    render inertia: "MyDesigns", props: {
      designs: designs
    }
  end

  # GET /vote - all approved designs for voting
  def all
    designs = Airtable::Design.approved.all.map do |d|
      d.as_approved_json(user_id: current_user&.identifier)
    end

    render inertia: "Vote", props: {
      designs: designs
    }
  end

  # POST /api/designs - create new design
  def create
    design = Airtable::Design.new(
      cdn_url: params.dig(:fields, :CDN_URL),
      name: params.dig(:fields, :Name) || "Untitled",
      slack_id: current_user.identifier,
      status: "pending",
      votes: 0
    )

    if design.save
      render json: design.as_json(user_id: current_user.identifier), status: :created
    else
      render json: { error: "Failed to create design" }, status: :unprocessable_entity
    end
  end

  # POST /api/designs/:id/vote - toggle vote
  def vote
    design = Airtable::Design.find(params[:id])

    if design.nil?
      render json: { error: "Design not found" }, status: :not_found
      return
    end

    design.vote!(current_user.identifier)
    render json: design.as_approved_json(user_id: current_user.identifier)
  end
end
