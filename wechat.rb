require "qy_wechat_api"
require "forwardable"

QyWechatApi.configure do |config|
  config.logger = Logger.new(STDOUT)
end

class Wechat

  attr_accessor :wc, :appid  #wechat_client

  extend Forwardable
  def_delegators :wc, :is_valid?

  def initialize(corpid, corpsecret, appid)
    @wc = QyWechatApi::Client.new(corpid, corpsecret)
    @appid = appid
    raise "cannot connect wechat server with your message" unless is_valid?
  end

  def send_text(msg)
    wc.message.send_text("@all", "@all", "@all", appid, msg)
  end

end
