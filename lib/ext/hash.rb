class Hash
  def blank?
    empty? || all? { |k,v| v.blank? }
  end
end
