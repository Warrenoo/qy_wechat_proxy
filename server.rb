require "sinatra"
require 'rack/contrib'
require "pry"
require "./wechat"

use Rack::PostBodyContentTypeParser

WechatError = Class.new StandardError

error StandardError do
  error_message env['sinatra.error'].message
end

error WechatError do
  error_message env['sinatra.error'].message
end

before do
  error!("params missing") unless params[:coprid] && params[:corpsecret] && params[:appid]
  init_wechat_client(params[:coprid], params[:corpsecret], params[:appid])
end

# 发送文本信息
post '/send_text' do
  error!("message missing") unless params[:message]

  @wechat.send_text(params[:message])

  present "ok"
end


helpers do

  def error!(msg="未知错误")
    raise WechatError, msg
  end

  def error_message(msg)
    present({ status: 0, msg: msg })
  end

  def present(msg)
    render_json({ status: 1, data: msg })
  end

  def render_json(msg)
    msg.to_json
  end

  def init_wechat_client(coprid, corpsecret, appid)
    @wechat ||= Wechat.new(coprid, corpsecret, appid)
  end

end
