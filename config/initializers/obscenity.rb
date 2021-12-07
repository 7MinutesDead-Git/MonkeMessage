class Obscenity::Base
  # -------------------
  # Override profane check to include substring searches.
  def self.profane?(text)
    return(false) unless text.to_s.size >= 3

    blacklist.each do |foul|
      if text.scan(/(?=#{foul})/) >= 3 or foul == text && !whitelist.include?(foul)
        puts text.count(foul)
        puts foul
        puts text
        return true
      end
    end

    false
  end
end
