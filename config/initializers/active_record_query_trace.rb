if Rails.env.development?
  ActiveRecordQueryTrace.enabled = false
  ActiveRecordQueryTrace.lines = 10
  ActiveRecordQueryTrace.level = :app # :app, :full, :rails
end