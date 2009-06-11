When "I do not create a config" do
  # do nothing
end

Then(/^the amee config: \"(\w+)\" should be: \"(.*)\"$/) do |key, value|
  Amee::Config[key.intern].to_s.should == value
end

When(/I set the: \"(\w+)\" on the amee config with: \"(.*)\"$/) do |key, value|
  Amee::Config.set do |config|
    config[key.intern] = value
  end
end