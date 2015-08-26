class ScriptureForToday
  def self.generate
    verse = Bible::Scripture.limit(1).order('RANDOM()').pluck(:verse).first
    Scripture.get_verse(verse) rescue nil
  end

  private

  def verse
    Bible::Scripture.limit(1).order('RANDOM()').pluck(:verse).first
  end
end
