class DelayedDeleteNamespace

  @queue = :namespaces

  def self.perform
    Rails.logger.fatal "DelayedDeleteNamespace - start - #{Time.now}"
    Namespace.disabled.find_each { |namespace| namespace.destroy }
    Rails.logger.fatal "DelayedDeleteNamespace - end - #{Time.now}"
  end

end