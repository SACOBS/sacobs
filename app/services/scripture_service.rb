require 'scripture'
class ScriptureService
  def fetch
    verse = Bible::Scripture.limit(1).order('RANDOM()').pluck(:verse).first
    Scripture.get_verse(verse)
  rescue StandardError => error
    Rails.log.error error.inspect
    nil
  end
end
