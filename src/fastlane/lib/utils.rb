# Utility functions

require 'git'

def connected_device_id

  output = `system_profiler SPUSBDataType`
  device_id = output.match(/Serial Number: ([\w\d]{40})/)

  if device_id.nil?
    puts "Sorry could not find any connected devices to perform build with. Trying to fall back on Simulator\n"
    return nil
    #raise Exception.new('Could not find a local iOS device to compile the build against.')
  end

  puts "Found a connected iDevice with identifier: #{device_id[1]}\n"
  return device_id[1]

end

# Returns true if the `NO_DEPLOY` env var is set to 1
def deploy_disabled?
  ENV['NO_DEPLOY'] == '1'
end

# Returns true if the `NO_TEST` env var is set to 1
def test_disabled?
  ENV['NO_TEST'] == '1'
end

# Generate a list of commit subjects from `rev` to `HEAD`
# :rev: The git SHA to start the log from, defaults to `ENV[LAST_SUCCESS_REV']`
def generate_git_commit_log(rev=ENV['GIT_PREVIOUS_SUCCESSFUL_COMMIT'] || 'HEAD^^^^^')
  g = Git.open(ENV['PWD'], :log => Logger.new(STDOUT))
  begin
    change_log = g.log.between(rev).map { |c| "- " + c.message.lines.first.chomp }.join "\n"
    "Commit Log:\n\n#{change_log}\n"
  rescue
    "Unable to parse commit logs"
  end
end

# Memoized version of `generate_git_commit_log` which stores the result in `ENV['GIT_COMMIT_LOG']`.
def git_commit_log
  ENV['GIT_COMMIT_LOG'] || ENV['GIT_COMMIT_LOG'] = generate_git_commit_log
end

# Parses JSON output of `plutil`
def info_plist_to_hash(path)
  require 'json'
  JSON.parse! %x[plutil -convert json -o - #{path}]
end

# Hack to read app version from Info.plist
def get_version_short_string(path)
  plist_hash = info_plist_to_hash path
  plist_hash['CFBundleShortVersionString']
end