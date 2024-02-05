class WebsocketController < ApplicationController
  include ActionController::Live

  def prices
    response.headers['Content-Type'] = 'text/event-stream'
    websocket = Faye::WebSocket.new(response.stream)

    websocket.on :open do |event|
      Rails.logger.info('WebSocket connection opened')
    end

    websocket.on :message do |event|
      Rails.logger.info("WebSocket received message: #{event.data}")
    end

    # Binance WebSocket connection logic
    binance_websocket_url = 'wss://stream.binance.com:9443/ws/btcusdt@trade'

    ws = Faye::WebSocket::Client.new(binance_websocket_url)

    ws.on :message do |msg|
      # Process the received message, extract price, and trigger alerts
      price = JSON.parse(msg.data)['p'].to_f
      process_price(price)
    end

    websocket.on :close do |event|
      Rails.logger.info("WebSocket connection closed: #{event.code}, #{event.reason}")
      ws.close if ws&.open?
    end

    render body: nil
  end

  private

  def process_price(price)
    # Implement logic to compare price with user alerts and trigger alerts if needed
    Alert.trigger_alerts(price)
  end
end
