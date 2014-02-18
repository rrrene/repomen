require 'fileutils'

module Repomen
  module Repo
    module Handler
      # Handler for git repositories
      #
      # @todo Uses git's CLI, since Rugged is not playing nice GitHub
      #   Why is that?
      class Git < Base
        # Removes the repo from the filesystem
        # @return [void]
        def discard
          FileUtils.rm_rf(path) if repo_exists?
        end

        # Retrieves the repo from +@url+
        # @return [void]
        def retrieve
          if repo_exists?
            update_repo
          else
            clone_repo
          end
        end

        private

        def git(*args)
          `git #{args.join(' ')}`
        end

        def clone_repo
          FileUtils.mkdir_p path
          git :clone, url, path, '--depth=1 --quiet'
        end

        def git_options
          options = %w(--quiet)
          if config.only_last_revision
            options << '--depth=1'
          end
          options.join(' ')
        end

        def update_repo
          pull
        end

        def pull
          old_dir = Dir.pwd
          Dir.chdir path
          git :pull, '--quiet'
          Dir.chdir old_dir
        end

        def repo_exists?
          File.exists?(path) && File.directory?(path)
        end
      end
    end
  end
end
