module Repomen
  module Repo
    module Service
      class GitHub < Base
        SERVICE_REGEXP = /(https:\/\/|git:\/\/|git\@)github.com[\:\/]([^\/]+)\/(.+)\.git$/

        # @param url [String]
        def applicable?
          url =~ SERVICE_REGEXP
        end

        def handler_class
          Handler::Git
        end

        # overriding 'git_hub' here to make directories look prettier
        def name
          :github
        end

        def repo_name
          url =~ SERVICE_REGEXP && $3
        end

        def user_name
          url =~ SERVICE_REGEXP && $2
        end

      end
    end
  end
end
