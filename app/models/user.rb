class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :messages
  has_many :matches
  has_many :user_preferences
  has_many :preferences, through: :user_preferences
  belongs_to :location, optional: true

  def matches
    matches = Match.where(first_user: self, first_like: true, second_like: true)
    matches += Match.where(second_user: self, first_like: true, second_like: true)
  end

  def has_match?(user)
    (self.matches & user.matches).blank? ? false : true
  end

  def like(user)
    match_first = Match.where(first_user: self, second_user: user)
    match_second = Match.where(first_user_id: user, second_user: self)
    if match_first.blank?
      if match_second.blank?
        Match.create(first_user: self, first_like: true, second_user: user)
      else
        match_second.first.update(second_like: true)
        if match_second.first.match?
          match_second.first.create_chat
          return match_second.first
        end
      end
    else
      match_first.first.update(first_like: true)
      if match_first.first.match?
        match_first.first.create_chat
        return match_first.first
      end
    end
  end

  def reject(user)
    match_first = Match.where(first_user: self, second_user: user)
    match_second = Match.where(first_user: user, second_user: self)
    if match_first.blank?
      if match_second.blank?
        Match.create(first_user: self, first_like: false, second_user: user)
      else
        match_second.first.update(second_like: false)
      end
    else
      match_first.first.update(first_like: false)
    end
  end

  def single_user_timeline
    return timeline.first
  end

  def timeline
    matchable = []
    users = []
    User.where.not(id: self.id).joins(:location).merge(Location.where(city: self.location.city)).each do |user|
      if !has_match?(user)
        common = self.preferences & user.preferences
        matchable.push({ "user": user, "rank": common.size })
      end
    end
    matchable.sort_by{ |r| r[:rank] }.reverse.each do |m|
      users.push m[:user]
    end
    users
  end

end
