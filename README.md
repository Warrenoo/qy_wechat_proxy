# qy_wechat_proxy
## FEATURE
a http server for proxy request to wechat qy
## START
``bundle``

``bundle exec ruby server.rb -e production``

## APIS
1. /send_text
  - method: post
  - params: corpid, corpsecret, appid, message
  - return: 
    - success: {status: 1, data: "ok"}
    - fail:    {status: 0, msg: error_msg}

