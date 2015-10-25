Given(/^I start with (\d+)$/) do |n|
  @number = n.to_i
  sleep 1
end

When(/^I add (\d+)$/) do |n|
  @number += n.to_i
end

When(/^I multiply by (\d+)$/) do |n|
  if Cucumber::Parallel.context > 1
    raise "Multiplication failed in context #{Cucumber::Parallel.context}"
  end
end

Then(/^I have (\d+)$/) do |n|
  expect(@number).to eq n.to_i
end
