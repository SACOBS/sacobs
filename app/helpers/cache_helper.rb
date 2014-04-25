module CacheHelper
  def cache_key_for_clients(clients)
    count = clients.count
    max_updated_at = clients.max_by(&:updated_at).try(:utc).try(:to_s, :number)
    "clients/all#{clients.current_page}-#{count}-#{max_updated_at}"
  end
end