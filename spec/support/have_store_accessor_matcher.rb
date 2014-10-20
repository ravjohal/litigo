module Shoulda
  module Matchers
    module ActiveRecord
      def have_store_accessor(key)
        HaveStoreAccessor.new(key)
      end

      class HaveStoreAccessor
        def initialize(key)
          @key = key
          @options = {}
        end

        def within(store_attribute)
          @options[:store_attribute] = store_attribute
          self
        end

        def matches?(subject)
          @subject = subject
          key_accessor_exists? && correct_store?
        end

        def description
          desc = "have store accessor named #{@key}"
          desc << " within the #{@options[:store_attribute]}" if @options.key?(:store_attribute)
        end

        def failure_message_for_should
          "Expected #{expectation} (#{@missing})"
        end

        def failure_message_for_should_not
          "Did not expect #{expectation}"
        end

        protected
          def key_accessor_exists?
            if @subject.respond_to?(@key) && @subject.respond_to?("#{@key}=")
              true
            else
              @missing = "#{@subject.class} does not have a store accessor named #{@key}"
            end
          end

          def correct_store?
            return true unless @options.key?(:store_attribute)

            @subject.send(:"#{@key}=", '1')
            val = @subject.send(@key)
            val == '1' && @subject.send(@options[:store_attribute])[@key] == val
          rescue
            false
          end

          def expectation
            expected = "#{@subject.class} to #{description}"
          end
      end
    end
  end
end

