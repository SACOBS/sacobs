class Hash
  def blank?
    empty? || all? { |_k, v| v.blank? }
  end
end
