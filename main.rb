require "twitter"
require "./word.rb"
require "dotenv"

Dotenv.load

stream_client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV["MY_CONSUMER_KEY"]
      config.consumer_secret     = ENV["MY_CONSUMER_SECRET"]
      config.access_token        = ENV["MY_ACCESS_TOKEN"]
      config.access_token_secret = ENV["MY_ACCESS_TOKEN_SECRET"]
end

client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["MY_CONSUMER_KEY"]
      config.consumer_secret     = ENV["MY_CONSUMER_SECRET"]
      config.access_token        = ENV["MY_ACCESS_TOKEN"]
      config.access_token_secret = ENV["MY_ACCESS_TOKEN_SECRET"]
end

meisi = ""

client.home_timeline(count: 20).each do |tweet|
      next if tweet.text.match(/@/) != nil
      word = Word.new(tweet.text)
      meisi = word.get_word("名詞,一般", 2)
      if meisi != "not" 
            puts word.get_initial_list
            break
      end
end

client.update("#{meisi}しゅきしゅきbotを観測")
