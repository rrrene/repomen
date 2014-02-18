module Repomen
  module Repo
    class URL
      def initialize(url)
        @url = url
        Repo::Service.for(url)
      end

      def service_name
      end

      def user_name
      end

      def repo_name
      end
    end
  end
end