class ReferralLogsController < ApplicationController
  before_action :set_referral_log, only: [:show, :edit, :update, :destroy]

  # GET /referral_logs
  # GET /referral_logs.json
  def index
    @referral_logs = ReferralLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @referral_logs }
    end
  end

  # GET /referral_logs/1
  # GET /referral_logs/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @referral_log }
    end
  end

  # GET /referral_logs/new
  def new
    @referral_log = ReferralLog.new
  end

  # GET /referral_logs/1/edit
  def edit
  end

  # POST /referral_logs
  # POST /referral_logs.json
  def create
    @referral_log = ReferralLog.new(referral_log_params)

    respond_to do |format|
      if @referral_log.save
        format.html { redirect_to @referral_log, notice: 'Referral log was successfully created.' }
        format.json { render json: @referral_log, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @referral_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referral_logs/1
  # PATCH/PUT /referral_logs/1.json
  def update
    respond_to do |format|
      if @referral_log.update(referral_log_params)
        format.html { redirect_to @referral_log, notice: 'Referral log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @referral_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referral_logs/1
  # DELETE /referral_logs/1.json
  def destroy
    @referral_log.destroy
    respond_to do |format|
      format.html { redirect_to referral_logs_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_referral_log
    @referral_log = ReferralLog.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def referral_log_params
    params.require(:referral_log).permit(:params, :parent_id)
  end
end
