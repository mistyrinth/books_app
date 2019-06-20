class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :load_commentable

  def index
    @reports = Report.page(params[:page]).per(5)
    @current_user = current_user
  end

  def new
    @report = Report.new
  end

  def show
    @comment = @report.comments.build
    @comments = Comment.where(commentable_type: "reports", commentable_id: @report ).order(created_at: :desc)
  end

  def create
    @report = Report.new(report_params)
    @comment = @report.comments.build

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: t('.notice') }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: t('.notice') }
      format.json { head :no_content }
    end
  end

  private
  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :body)
  end

  def load_commentable
    @commentable = @report
  end
end
