require 'scripture'
class ScriptureService

  def initialize
    @attempts = 0
  end

  def fetch
    verse = Bible::Scripture.limit(1).order("RANDOM()").pluck(:verse).first
    Scripture.get_verse(verse)
  rescue
    return
  end
end