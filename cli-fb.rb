require 'readline'
require 'koala'
require 'omniauth'
require 'omniauth-facebook'

oauth_access_token = "CAALlHK7WhCEBACmhpXbSKjZAySCAKromCO5EfglcmfOEnCpSbUrZBhLpuHLpnWZBFvdRnlMFiiZBeD7U95A05zWA7andAkRyOcNlUcwl3vsI6tE6ZBenbZC7jTUt8hD1noWtZAgLMJmsacmnnuwEUv9thxMMLu5rQmYYk84ZAXN00UPgfAoBS96B3oWtnT6J6sIj8Oebu0utcm4HKSlcRT2SErwfABYJyeUZD"
@graph = Koala::Facebook::API.new(oauth_access_token)

@feed_length = 0

LIST = [
  'newest_feed', 'near_feed', 'post_picture',
  'post_status',
  'help', 'history', 'quit',
].sort

def updated_feed
  feed = @graph.get_connections("me", "feed").first
  puts "User #{feed["story"]}"
end

def near_feed
  feed = @graph.get_connections("me", "feed")
  @feed_length = 4
  (0..4).each do |i|
    puts "New feed #{i}: User #{feed[i]["story"]}" if feed[i]["story"]
    puts "New feed #{i}: User #{feed[i]["message"]}" if feed[i]["message"]
    puts "\n"
  end
end

def next_feed
  feed = @graph.get_connections("me", "feed")
  index = 4
  if @feed_length + 5 > feed.length
    index = feed.length
  else
    index = @feed_length + 5
  end

  (index - 4..index).each do |i|
    puts "New feed #{i}: User #{feed[i]["story"]}" if feed[i]["story"]
    puts "New feed #{i}: User #{feed[i]["message"]}" if feed[i]["message"]
    puts "\n"
  end
  @feed_length += 5
end

def post_picture line
  split = line.split
  if split[1]
    begin
      @graph.put_object("me", "feed", {:picture => split[1], :message => split[2]})
    rescue
      puts "picture is not properly formatted"
    else
      puts "Picture is uploaded"
    end
  else
    puts "Insert picture link, plz"
    return false
  end
end

def post_status line
  split = line.split
  if split[1]
    @graph.put_object("me", "feed", {:message => split[1]})
    puts "Posted status #{split[1]}"
  else
    puts "Insert status plz"
  end
end

def history
  Readline::HISTORY.to_a.each do |history|
    puts history
  end
end

def help
  puts 'newest_feed:  Get newest feed'
  puts 'near_feed: Get 5 newest feed'
  puts 'history: Show history command'
  puts 'post_picture url_link message : Post picture with message to your wall'
  puts 'post_status message : Post message to your wall'
  puts 'next_feed: Get 5 next newest feed'
end

comp = proc { |s| LIST.grep( /^#{Regexp.escape(s)}/ ) }

Readline.completion_append_character = " "
Readline.completion_proc = comp

while line = Readline.readline('>> ', true)
  puts line
  updated_feed if line.index 'newest_feed'
  newest_homepage if line.index "newest_homepage"
  near_feed if line.index 'near_feed'
  next_feed if line.index 'next'
  post_picture line if line.index 'post_picture'
  post_status line if line.index 'post_status'
  history if line.index "history"
  help if line.index "help"
end

