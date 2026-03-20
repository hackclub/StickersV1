# frozen_string_literal: true

class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: true

  def self.from_omniauth(auth)
    find_or_create_by(uid: auth.uid) do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.slack_id = auth.extra&.raw_info&.slack_id
    end
  end

  def identifier
    slack_id || uid
  end
end
