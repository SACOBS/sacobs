class SequenceGenerator
  def initialize(record)
    @record = record
    @model = record.class
  end

  def execute
    next_id if @record.sequence_id.nil?
  end

  private

  def find_last_record
    @model.where.not(sequence_id: nil).order(sequence_id: :desc).first
  end

  def next_id
    next_id_in_sequence.tap { |id| id.next until unique?(id) }
  end

  def unique?(id)
    !@model.exists?(sequence_id: id)
  end

  def next_id_in_sequence
    start_at = 1
    last_record = find_last_record
    return start_at unless last_record
    max(last_record.send(:sequence_id) + 1, start_at)
  end

  def max(*values)
    values.to_a.max
  end
end
