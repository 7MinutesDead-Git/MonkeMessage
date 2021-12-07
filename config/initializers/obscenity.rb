class Obscenity::Base
  # -------------------
  # Override profane check to include substring searches.
  def self.profane?(text)
    return(false) unless text.to_s.size >= 3

    blacklist.each do |foul|
      if foul.in?(text) && !whitelist.include?(foul)
        return true
      end
    end

    false
  end
end
