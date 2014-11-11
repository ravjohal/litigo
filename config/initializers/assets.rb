# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.assets.precompile += %w( homepage.css )
Rails.application.config.assets.precompile += %w( hopscotch.js jasny-bootstrap.js jquery.collapsible.js jquery.feedback_me.js tipr.js sugar.min.js linq.min.js welcome_tour.js tag-it.js)
