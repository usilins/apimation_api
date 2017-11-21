Before do
  puts 'This hook will be executed before every scenario'
end

Before('@login') do
  puts 'This hook will be executed before scenarios tagged with @login tag'
end

After do |scenario|
  puts 'The scenario has failed!' if scenario.failed?
end