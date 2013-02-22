require 'rubygems'
require 'oauth'

consumer_key = 'P-idX6jBuMXiG2wRlfilrQ'
consumer_secret = '12Cpqnroi9n-_ob9IHHHoRpexuI'
token = 'we2lOBfKpf5l7B9YSLDmxbmgSq_GLbtt'
token_secret = 'r1o-A0t0bywBVmJsLqzcc5X81u4'

api_host = 'api.yelp.com'

consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
access_token = OAuth::AccessToken.new(consumer, token, token_secret)

path = "/v2/search?term=restaurants&location=new%20york"

p access_token.get(path).body
