# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.assets.precompile += %w( homepage.css .woff .ttf)
Rails.application.config.assets.precompile += %w( jasny-bootstrap.js jquery.collapsible.js jquery.feedback_me.js tipr.js sugar.min.js linq.min.js tag-it.js tasks/*.js notes/*.js contacts/*.js documents/*.js time_entries/*.js templates/*.js task_lists/*.js shared/*.js settlements/*.js resolutions/*.js reports/*.js registrations/*.js namespaces/*.js medicals/*.js interrogatories/*.js insurances/*.js injuries/*.js incidents/*.js expenses/*.js client_intakes/*.js cases/*.js notifications/*.js dashboards/*.js)
