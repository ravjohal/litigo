# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.assets.precompile += %w( homepage.css .woff .ttf)
Rails.application.config.assets.precompile += %w( jasny-bootstrap.js jquery.collapsible.js jquery.feedback_me.js tipr.js sugar.min.js linq.min.js tag-it.js tasks/*.js notes/*.js)
