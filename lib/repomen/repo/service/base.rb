module Repomen
  module Repo
    module Service
      class Base
        SERVICE_REGEXP = //

        attr_reader :url

        # @param url [String]
        def applicable?
          url =~ SERVICE_REGEXP
        end

        def initialize(url)
          @url = url
        end

        def name
          self.class.to_s.split("::").last.underscore.to_sym
        end
      end
    end
  end
end
