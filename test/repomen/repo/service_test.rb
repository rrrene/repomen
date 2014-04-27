require File.expand_path(File.dirname(__FILE__) + '/../../test_helper')

describe ::Repomen::Repo::Service do
  let(:described_class) { ::Repomen::Repo::Service }

  it "should recognize a GitHub URL via git" do
    url = "git@github.com:octocat/Hello-World.git"
    service = described_class.for(url)
    refute service.nil?
    assert_equal :github, service.name
  end

  it "should recognize a GitHub URL with .rb at the end via git" do
    url = "git@github.com:bfontaine/Graphs.rb.git"
    service = described_class.for(url)
    refute service.nil?
    assert_equal :github, service.name
  end

  it "should recognize a BitBucket URL via git" do
    url = "git@bitbucket.org:atlassian_tutorial/helloworld.git"
    service = described_class.for(url)
    refute service.nil?
    assert_equal :bitbucket, service.name
  end
end
