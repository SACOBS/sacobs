class NullUser
  def id
    0
  end

  def admin?
    false
  end

  def clerk?
    false
  end

  def !
    true
  end
end
