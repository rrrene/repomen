require File.expand_path(File.dirname(__FILE__) + '/../../../test_helper')

describe ::Repomen::Repo::Service::GitHub do
  let(:described_class) { ::Repomen::Repo::Service::GitHub }

  it "should recognize a Github URL via git" do
    url = "git@github.com:octocat/Hello-World.git"
    service = described_class.new(url)
    assert service.applicable?
    assert_equal "octocat", service.user_name
    assert_equal "Hello-World", service.repo_name
  end

  it "should recognize a Github URL via git protocol" do
    url = "git://github.com/octocat/Hello-World.git"
    service = described_class.new(url)
    assert service.applicable?
    assert_equal "octocat", service.user_name
    assert_equal "Hello-World", service.repo_name
  end

  it "should recognize a Github URL via https" do
    url = "https://github.com/octocat/Hello-World.git"
    service = described_class.new(url)
    assert service.applicable?
    assert_equal "octocat", service.user_name
    assert_equal "Hello-World", service.repo_name
  end
end
