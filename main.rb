require 'mastodon'
require 'parseconfig'
require "rss"



MYCONF=ParseConfig.new('config')

url = MYCONF['blog_rss_url']
TOKEN=MYCONF['mastodon_token']
client =  Mastodon::REST::Client.new(base_url: 'https://mastodon.social', bearer_token: TOKEN)

loop do
  RSS::Parser.parse(url).channel.items.each do|x|
    client.create_status "#{x.title} \n #{x.link}"
    sleep(60 * 60)
  end
end
