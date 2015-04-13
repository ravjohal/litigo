Htmltoword.configure do |config|
  config.default_templates_path = "#{Rails.root}/lib/htmltoword/template/"
  config.default_xslt_path = "#{Rails.root}/lib/htmltoword/xslt/"
end