class TagsController < ApplicationController
  def index
    @tags = Category.all
    render :index
  end
  def show
    @tag = Category.find(params[:id])
    @wallets = ScrapableAddress.all
    render :show
  end
  def edit
    @tag = Category.find(params[:id])
    @wallets = ScrapableAddress.all
    render :edit
  end
  def search
    @transactions = Transaction
    @wallets = ScrapableAddress.all
    @transaction_from = params[:transaction_from]
    @transaction_to = params[:transaction_to]
    if @transaction_from.present?
      @transactions = @transactions.where(from: @transaction_from)
    end
    if @transaction_to.present?
      @transactions = @transactions.where(to: @transaction_to)
    end
    respond_to do |format|
      format.js { render :search }
    end
  end
  def bulk_update
    @tag = Category.find(params[:tag_id])
    @transactions = Transaction
    @wallets = ScrapableAddress.all
    @transaction_from = params[:hidden_transaction_from]
    @transaction_to = params[:hidden_transaction_to]
    if @transaction_from.present?
      @transactions = @transactions.where(from: @transaction_from)
    end
    if @transaction_to.present?
      @transactions = @transactions.where(to: @transaction_to)
    end
    @transactions.each do |tx|
      tx.categories << @tag
    end
    respond_to do |format|
      format.js { render :bulk_update }
    end
  end
end
