module ActiveNamespaces

  def enabled_namespaces
    namespaces.where(:enabled => true)
  end

  def disabled_namespaces
    namespaces.where(:enabled => true)
  end

end