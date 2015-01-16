require 'scripture'
class ScriptureService
  def fetch
    verse = Bible::Scripture.limit(1).order('RANDOM()').pluck(:verse).first
    Scripture.get_verse(verse)
  rescue  => e
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
    nil
  end
end
