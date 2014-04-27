require File.expand_path(File.dirname(__FILE__) + '/../../../test_helper')

describe ::Repomen::Repo::Handler::Git do
  before do
    tmp_dir = File.join(Repomen::ROOT, "tmp")
    Repomen.config.work_dir = tmp_dir
  end

  let(:described_class) { ::Repomen::Repo::Handler::Git }
  let(:dir) { "octocat/Hello-World" }

  describe "#retrieve" do
    it "should recognize a Github URL via git" do
      url = "git@github.com:octocat/Hello-World.git"
      handler = described_class.new(url, dir)
      handler.retrieve
      assert File.exists?(handler.path)
      assert File.directory?(handler.path)

      assert handler.revision_info
      info = handler.revision_info
      refute info["name"].nil?
      refute info["email"].nil?
      refute info["date"].nil?
      refute info["commit"].nil?
      refute info["message"].nil?
    end

    it "should recognize a Github URL via https" do
      url = "https://github.com/octocat/Hello-World.git"
      handler = described_class.new(url, dir)
      handler.retrieve
      assert File.exists?(handler.path)
      assert File.directory?(handler.path)

      handler.discard
      assert !File.exists?(handler.path)
    end
  end

  describe "#git_options" do
    it "should include --depth=1 if only_last_revision is set" do
      url = "git@github.com:octocat/Hello-World.git"
      handler = described_class.new(url, dir, {:only_last_revision => true})
      options = handler.method(:git_options).call
      assert options.include?('--depth=1')
    end

    it "should NOT include --depth=1 if only_last_revision is set" do
      url = "git@github.com:octocat/Hello-World.git"
      handler = described_class.new(url, dir, {:only_last_revision => false})
      options = handler.method(:git_options).call
      assert !options.include?('--depth=1')
    end
  end
end
