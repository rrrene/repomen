require 'fileutils'

module Repomen
  module Repo
    module Handler
      # Handler for git repositories
      #
      # @todo Uses git's CLI, since Rugged is not playing nice GitHub
      #   Why is that?
      class Git < Base
        def branch_name
          branch = nil
          in_dir do
            branch = git 'rev-parse', '--abbrev-ref', 'HEAD'
          end
          branch.strip
        end

        def change_branch(name)
          in_dir do
            git :checkout, name, '--quiet'
          end
        end

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
          $?.success?
        end

        def revision
          rev = nil
          in_dir do
            rev = git 'rev-parse', 'HEAD'
          end
          rev.strip
        end

        private

        def git(*args)
          `git #{args.join(' ')}`
        end

        def in_dir(dir = @path, &block)
          Dir.chdir(dir, &block)
        end

        def clone_repo
          FileUtils.mkdir_p path
          git(:clone, url, path, '--quiet')
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
          in_dir do
            git(:pull, '--quiet')
          end
        end

        def repo_exists?
          File.exist?( File.join(path, ".git") )
        end
      end
    end
  end
end
