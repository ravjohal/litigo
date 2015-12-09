module LoggedJob
  def before_perform_log_job(*args)
    Rails.logger.info "About to perform #{self} with #{args.inspect}"
  end
end

module RetriedJob
  def on_failure_retry(e, *args)
    Rails.logger.info "Performing #{self} caused an exception (#{e}). Retrying..."
    Resque.enqueue self, *args
  end
end


class SyncAllCalendars
  extend LoggedJob
  extend RetriedJob
  # extend ScaledJob

	@queue = :calendar

	def self.perform
    Rails.logger.fatal "SyncAllCalendars - start - #{Time.now}"

    Firm.find_each{|firm| firm.sync_namespaces(firm) }

    Rails.logger.fatal "SyncAllCalendars - end - #{Time.now}"
  end

end