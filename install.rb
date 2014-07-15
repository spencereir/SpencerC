begin
  gem "colored"
rescue Gem::LoadError
  system("gem install colored 2>&1")
  unless $? == 0
    e = Exception.new(3, "colored", 0)
  end
end

# TODO: Make this only run if windows
begin
  gem "win32console"
rescue Gem::LoadError
  system("gem install win32console 2>&1")
  unless $? == 0
    e = Exception.new(3, "win32console", 0)
  end
end
