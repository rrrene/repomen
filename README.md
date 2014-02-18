# Repomen

The Repomen are retrieving repos and can discard them at will.



## Installation

Add this line to your application's Gemfile:

    gem 'repomen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install repomen



## Usage

The Repomen are retrieving repos and can discard them at will.

    url = "git@bitbucket.org:atlassian_tutorial/helloworld.git"
    Repomen.retrieve(url)

When called with a block, the repo is automatically deleted afterwards

    Repomen.retrieve(url) do |local_path|
      # repo is cloned in +local_path+
    end
    # repo is gone

You can set the directory where the repos are stored:

    Repomen.config.work_dir = "tmp/"

The naming scheme for the cloned repos is `service/user/repo`. In the example `https://github.com/rrrene/sparkr.git` would be cloned to `tmp/github/rrrene/sparkr`.



## Contributing

1. [Fork it!](http://github.com/rrrene/repomen/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



## Author

René Föhring (@rrrene)



## License

Repomen is released under the MIT License. See the LICENSE.txt file for further
details.
