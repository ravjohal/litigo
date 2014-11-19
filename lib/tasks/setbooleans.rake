desc "Set all Boolean fields within database that are nil to default value of false"
task :setbooleans => :environment do 

	models = get_models

	models.each {|m|
		model = m.constantize
		model.columns_hash.each { |k,v|
			puts "K ====> " + k.to_s + " |  V.TYPE ====> " + v.type.to_s + " TRUE? " + (v.type.to_s == "boolean").to_s

			table = model.to_s.downcase.pluralize.underscore
			puts "MODEL UNDERSCORED ;;;;;;;;;;;; " + table
			if v.type.to_s == "boolean"
				sql = "ALTER TABLE #{table} ALTER COLUMN #{k} SET DEFAULT false;"
				bool_false = ActiveRecord::Base.connection.execute(sql)
				puts sql
				puts k
			end
		}
	}
end

desc "Set all existing boolean fields to false if they are nil"
task :setfalse => :environment do
	# grab all models and its attributes and then set all booleans to false if they are nil
	models = get_models

	models.each { |m| 
		model = m.constantize
		puts "MODEL NAME ---------- " + model.to_s
		model.all.each { |obj|
			obj.attributes.each { |k,v|
				puts "MODEL ATTRIBUTE TYPE ====> " + model.column_for_attribute(k).type.to_s + " <<<<< Value>>>> " + v.to_s
				if model.column_for_attribute(k).type.to_s == "boolean" && v == nil
					obj.update_attribute(k, false)
				end
			}
		}
	}
end

def get_models
	Rails.application.eager_load!
	
	models = ActiveRecord::Base.send(:subclasses).map(&:name)

	models.delete("PgSearch::Document")
	models.delete("EventAttendee")
	models.delete("GoogleCalendar")
	models.delete("UserEvent")
	puts "Hello" + models.to_s
	return models
end
