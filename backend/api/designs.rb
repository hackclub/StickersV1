# frozen_string_literal: true

class Designs < Grape::API
  format :json
  helpers SessionHelpers
  resource :designs do
    get :all do
      error!('Unauthorized', 401) unless current_user
      user_id = current_user.identifier
      Design.approved.all.map { |d| d.as_approved_json(user_id: user_id) }
    end

    get do
      error!('Unauthorized', 401) unless current_user
      user_id = current_user.identifier
      Design.by_user(user_id).all.map { |d| d.as_json(user_id: user_id) }
    end

    post do
      error!('Unauthorized', 401) unless current_user
      safe_fields = (params[:fields] || {}).slice(*Design::ALLOWED_FIELDS)
      safe_fields['slack_id'] = current_user.identifier
      safe_fields['Votes'] = 0
      safe_fields['Status'] = 'pending'
      Design.create(safe_fields)
    end

    route_param :id do
      post :vote do
        error!('Unauthorized', 401) unless current_user
        user_id = current_user.identifier
        design = Design.find(params[:id])
        error!('Design not found', 404) unless design

        voted_by = (design['voted_by'] || '').split(',').map(&:strip).reject(&:empty?)
        current_votes = design['Votes'] || 0

        if voted_by.include?(user_id)
          voted_by.delete(user_id)
          design['Votes'] = [current_votes - 1, 0].max
        else
          voted_by << user_id
          design['Votes'] = current_votes + 1
        end

        design['voted_by'] = voted_by.join(',')
        design.save
        { success: true, votes: design['Votes'], voted: voted_by.include?(user_id) }
      end
    end
  end
end
