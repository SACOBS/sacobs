require 'scripture'
class ScriptureService
  def self.fetch
    verse = Bible::Scripture.limit(1).order("RANDOM()").pluck(:verse).first
    Scripture.get_verse(verse)
  rescue
    fetch
  end

end