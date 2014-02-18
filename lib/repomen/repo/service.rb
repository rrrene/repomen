module Repomen
  module Repo
    module Service
      class << self
        def for(url)
          services.each do |service_class|
            s = service_class.new(url)
            return s if s.applicable?
          end
          nil
        end

        def services
          [Service::GitHub, Service::BitBucket]
        end
      end
    end
  end
end

require_relative 'service/base'
require_relative 'service/git_hub'
require_relative 'service/bit_bucket'
