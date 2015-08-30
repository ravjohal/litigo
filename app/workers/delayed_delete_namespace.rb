class DelayedDeleteNamespace

  @queue = :namespaces

  def self.perform
    Namespace.disabled.find_each { |namespace| namespace.destroy }
  end

end