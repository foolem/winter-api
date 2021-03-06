class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :messages, dependent: :destroy
  has_many :matches
  has_many :user_preferences, dependent: :destroy
  has_many :preferences, through: :user_preferences
  belongs_to :location, optional: true

  before_destroy :destroy_matches_and_chats

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def matches
    matches = Match.where(first_user: self, first_like: true, second_like: true)
    matches += Match.where(second_user: self, first_like: true, second_like: true)
  end

  def possibly_matches
    matches = Match.where(first_user: self)
    matches += Match.where(second_user: self)
  end

  def has_possibly_match?(user)
    matches = Match.where(first_user: self, second_user: user)
    matches += Match.where(first_user: user, second_user: self)
    (matches.blank?) ? false : true
  end

  def user_not_liked(user)
    matches = Match.where(first_user: self, first_like: true, second_user: user)
    matches += Match.where(first_user: user, second_like: true, second_user: self)
    matches += Match.where(first_user: self, first_like: false, second_user: user)
    matches += Match.where(first_user: user, second_like: false, second_user: self)
    (matches.blank?) ? true : false
  end

  def has_match?(user)
    matches = Match.where(first_user: self, first_like: true, second_user: user, second_like: true)
    matches += Match.where(second_user: self, first_like: true, first_user: user, second_like: true)
    (matches.blank?) ? false : true
  end

  def seen_top_5?
    self.seen_top_5 == true ? true : false
  end

  def reset_top_5
    if self.seen_top_5_time.blank? || (self.seen_top_5? == true && (TimeDifference.between(self.seen_top_5_time, Time.current).in_days > 1))
      self.update(seen_top_5: false)
      return true
    else
      phrase = "Você ainda não pode visualizar os 5 melhores! Espere #{(24 - TimeDifference.between(Time.current, self.seen_top_5_time).in_hours).to_i}h:#{(60 - TimeDifference.between(Time.current, self.seen_top_5_time).in_minutes).to_i}m"
      return phrase
    end
  end

  def like(user)
    match_first = Match.where(first_user: self, second_user: user)
    match_second = Match.where(first_user: user, second_user: self)
    if match_first.blank?
      if match_second.blank?
        m = Match.create(first_user: self, first_like: true, second_user: user)
        return m
      else
        match_second.first.update(second_like: true)
        if match_second.first.match?
          match_second.first.create_chat
          return match_second.first
        end
        return match_second.first
      end
    else
      match_first.first.update(first_like: true)
      if match_first.first.match?
        match_first.first.create_chat
        return match_first.first
      end
      return match_first.first
    end
  end

  def reject(user)
    match_first = Match.where(first_user: self, second_user: user)
    match_second = Match.where(first_user: user, second_user: self)
    if match_first.blank?
      if match_second.blank?
        m = Match.create(first_user: self, first_like: false, second_user: user)
      else
        match_second.first.update(second_like: false)
        match_second.first
      end
    else
      match_first.first.update(first_like: false)
      match_first.first
    end
  end

  def single_user_timeline
    return timeline.first if timeline != false
    return {"error": "Ninguém para dar like"}
  end

  def same_sex_preference(user)
    (self.sex_preference == user.sex || self.sex_preference == 2) ? true : false
  end

  def timeline
    matchable = []
    users = []
    count = 0
    User.where.not(id: self.id).joins(:location).merge(Location.where(city: self.location.city)).each do |user|
      if (same_sex_preference(user) && user_not_liked(user) && !has_match?(user) && count < 5)
        puts user
        common = common_preferences(user)
        matchable.push({ "user": user, "rank": common.size })
        count += 1
      elsif (count < 5)
        next
      else
        break
      end
    end
    if !matchable.blank?
      matchable.sort_by{ |r| r[:rank] }.reverse.each do |m|
        users.push m[:user]
      end
      users
    else
      return false
    end
  end

  def top_5
    if !reset_top_5 || seen_top_5?
      return false
    else
      self.update(seen_top_5: true, seen_top_5_time: Time.current)
      return timeline[0..4]
    end
  end

  def common_preferences(user)
    user = is_user_integer?(user)
    common = self.preferences & user.preferences
    result = []
    common.each do |c|
      result.push({ id: c.id, sub_area_id: c.sub_area_id, area_id: c.sub_area.area_id, content: c.content })
    end
    result.to_json
  end

  def age(user)
    user = is_user_integer?(user)
    now = Time.current.to_date
    now.year - user.birthday.year - ((now.month > user.birthday.month || (now.month == user.birthday.month && now.day >= user.birthday.day)) ? 0 : 1)
  end

  def is_user_integer?(user)
    !(user.is_a? Integer) ? user : user = User.find(user)
  end

  private

  def destroy_matches_and_chats
    Match.where(first_user: self).each do |m|
      if !m.chat.blank?
        c = m.chat
        m.update(chat: nil)
        c.update(match: nil)
        Message.where(chat: c).destroy_all
        c.destroy
      end
      m.destroy
    end
    Match.where(second_user: self).each do |m|
      if !m.chat.blank?
        c = m.chat
        m.update(chat: nil)
        c.update(match: nil)
        Message.where(chat: c).destroy_all
        c.destroy
      end
      m.destroy
    end
  end

end
