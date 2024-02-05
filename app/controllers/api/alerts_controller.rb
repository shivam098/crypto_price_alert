class Api::AlertsController < ApplicationController
  # before_action :authenticate_user!

  # POST /api/alerts
  def create
    alert = current_user.alerts.build(alert_params)

    if alert.save
      render json: { message: 'Alert created successfully', alert: alert }, status: :created
    else
      render json: { errors: alert.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/alerts/:id
  def destroy
    alert = current_user.alerts.find(params[:id])

    if alert.destroy
      render json: { message: 'Alert deleted successfully' }
    else
      render json: { errors: alert.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /api/alerts
  def index
    alerts = current_user.alerts.page(params[:page]).per(params[:per_page])

    render json: { alerts: alerts, total_pages: alerts.total_pages, current_page: alerts.current_page }
  end

  private

  def alert_params
    params.require(:alert).permit(:coin_name, :target_price)
  end
end
