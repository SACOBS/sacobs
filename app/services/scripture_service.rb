require 'scripture'
class ScriptureService
  def fetch
    verse = Bible::Scripture.limit(1).order('RANDOM()').pluck(:verse).first
    Scripture.get_verse(verse)
  rescue
    return
  end
end
