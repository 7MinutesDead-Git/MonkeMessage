# frozen_string_literal: true

# Obscenity base class override. Obscenity is a gem for filtering profane language.
class Obscenity::Base
  # -------------------
  # Override profane check to include substring searches.
  def self.profane?(text)
    return(false) unless text.to_s.size >= 3

    blacklist.each do |foul|
      return true if foul.in?(text) && !whitelist.include?(foul)
    end

    false
  end
end
