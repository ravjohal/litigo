class CheckNamespace

  @queue = :namespaces

  def self.perform
    Namespace.enabled.find_each { |namespace| namespace.check_for_exists_in_nylas }
  end

end