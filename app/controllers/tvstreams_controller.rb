class TvstreamsController < ApplicationController
  before_action :set_tvstream, only: %i[ show edit update destroy ]

  # GET /tvstreams or /tvstreams.json
  def index
    @tvstreams = Tvstream.all
  end

  # GET /tvstreams/1 or /tvstreams/1.json
  def show
  end

  # GET /tvstreams/new
  def new
    @tvstream = Tvstream.new
  end

  # GET /tvstreams/1/edit
  def edit
  end

  # POST /tvstreams or /tvstreams.json
  def create
    @tvstream = Tvstream.new(tvstream_params)

    respond_to do |format|
      if @tvstream.save
        format.html { redirect_to tvstream_url(@tvstream), notice: "Tvstream was successfully created." }
        format.json { render :show, status: :created, location: @tvstream }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tvstream.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tvstreams/1 or /tvstreams/1.json
  def update
    respond_to do |format|
      if @tvstream.update(tvstream_params)
        format.html { redirect_to tvstream_url(@tvstream), notice: "Tvstream was successfully updated." }
        format.json { render :show, status: :ok, location: @tvstream }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tvstream.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tvstreams/1 or /tvstreams/1.json
  def destroy
    @tvstream.destroy!

    respond_to do |format|
      format.html { redirect_to tvstreams_url, notice: "Tvstream was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tvstream
      @tvstream = Tvstream.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tvstream_params
      params.require(:tvstream).permit(:name, :firsttv, :mytv, :tv_id)
    end
end
