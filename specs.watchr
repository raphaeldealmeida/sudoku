# Autotest specs with Watchr
# http://bjhess.com/blog/2010/2/23/setting_up_watchr_and_rails/

# Run me with:
# $ watchr specs.watchr

ENV["WATCHR"] = "1"
system 'clear'

def growl(message)
  #growlnotify = `which growlnotify`.chomp
  title = "Watchr Test Results"
  icons_path = '~/.icons/'  
  image = message.include?('0 failures') ? icons_path + 'passed.png' :
                                           icons_path + 'failure.png'
#  options = "-w -n Watchr --image '#{File.expand_path(image)}' -m '#{message}' '#{title}'"
  options = " #{title} '#{message}' "
  system ("notify-send -t 3000 -i #{image} '#{message}' &")

end

def run(cmd)
  puts(cmd)
  `#{cmd}`
end

def run_spec_file(file)
  system('clear')
  result = run(%Q(spec #{file} -cf nested &))
  growl result.split("\n").last rescue nil
  puts result
end

def run_all_specs
  system('clear')
  result = run "spec ./ "
  growl result.split("\n").last rescue nil
  puts result
end

# def run_all_features
#   system('clear')
#   system("cucumber")
# end

def related_spec_files(path)
  Dir['*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_spec.rb/ }
end

def run_suite
  run_all_specs
  # run_all_features
end

#watch('spec/spec_helper\.rb') { run_all_specs }
#watch('spec/.*/.*_spec\.rb') { |m| run_spec_file(m[0]) }
watch('.*_spec\.rb') { |m| run_spec_file(m[0]) }
#watch('app/.*/.*\.rb') { |m| related_spec_files(m[0]).map {|tf| run_spec_file(tf) } }
# watch('features/.*/.*\.feature') { run_all_features }

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running all tests ---\n\n"
  run_all_tests
end

@interrupted = false

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
    # raise Interrupt, nil # let the run loop catch it
    run_suite
  end
end

