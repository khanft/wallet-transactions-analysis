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
    @neutral = params[:neutral_cash] == "1" ? true : false
    @positive = params[:positive_cash] == "1" ? true : false
    @negative = params[:negative_cash] == "1" ? true : false

    if @transaction_from.present?
      @transactions = @transactions.where(from: @transaction_from)
    end
    if @transaction_to.present?
      @transactions = @transactions.where(to: @transaction_to)
    end
    unless @positive
      @transactions = @transactions.where.not('value > ?', 0)
    end
    unless @negative
      @transactions = @transactions.where.not('value < ?', 0)
    end
    unless @neutral
      @transactions = @transactions.where.not(value: 0)
    end    
    @transactions = @transactions.all

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
    @transactions.all.each do |tx|
      unless tx.categories.include? @tag
        tx.categories << @tag
      end
    end
    respond_to do |format|
      format.js { render :search }
    end
  end
end
