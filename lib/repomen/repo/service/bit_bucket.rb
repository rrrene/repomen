module Repomen
  module Repo
    module Service
      class BitBucket < Base
        SERVICE_REGEXP = /(https:\/\/|git\@)bitbucket.org[\:\/]([^\/]+)\/([^\.]+)\.git$/

        # @param url [String]
        def applicable?
          url =~ SERVICE_REGEXP
        end

        def handler_class
          Handler::Git
        end

        # overriding 'git_hub' here to make directories look prettier
        def name
          :bitbucket
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
