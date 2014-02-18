require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe ::Repomen::Config do
  let(:described_class) { ::Repomen::Config }

  it "should set the global working dir" do
    assert !Repomen.config.nil?
    tmp_dir = File.join(Repomen::ROOT, "tmp")
    Repomen.config.work_dir = tmp_dir
    assert_equal tmp_dir, Repomen.config.work_dir
  end

  it "should return a default working dir if set to nil" do
    Repomen.config.work_dir = nil
    assert !Repomen.config.work_dir.nil?
  end

  it "should set working dir" do
    tmp_dir = File.join(Repomen::ROOT, "tmp")
    config = Repomen::Config.new(:work_dir => tmp_dir)
    assert_equal tmp_dir, config.work_dir
  end
end
