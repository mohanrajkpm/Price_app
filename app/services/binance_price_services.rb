require 'faye/websocket'
require 'eventmachine'

EM.run {
  ws = Faye::WebSocket::Client.new('wss://stream.binance.com:9443/ws/btcusdt@ticker')

  ws.on :open do |event|
    p [:open]
  end

  ws.on :message do |event|
    results = JSON.parse event.data.gsub('=>', ':')

    price_changed = results['p']

    ReportStatus.perform_async(price_changed)
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
}
