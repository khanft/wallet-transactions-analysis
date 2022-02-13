class SearchTransactionsController < ApplicationController
  def index
    render :index
  end
  def query
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
      format.js { render :query }
    end
  end
  def bulk_update
    @tag = Category.find(params[:tag_id])
    @transactions = Transaction
    @wallets = ScrapableAddress.all
    @transaction_from = params[:hidden_transaction_from].present? ? params[:hidden_transaction_from] : nil
    @transaction_to = params[:hidden_transaction_to].present? ? params[:hidden_transaction_to] : nil
    @neutral = params[:hidden_neutral_cash] == "true" ? true : false
    @positive = params[:hidden_positive_cash] == "true" ? true : false
    @negative = params[:hidden_negative_cash] == "true" ? true : false
    if @transaction_from.nil? and @transaction_to.nil? and not @negative and not @neutral and not @positive
      @transactions = @transactions.where(from: @transaction_from)
      @transactions = @transactions.where(to: @transaction_to)
      respond_to do |format|
        format.js { render :query and return }
      end
    end
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
    @transactions.all.each do |tx|
      unless tx.categories.include? @tag
        tx.categories << @tag
      end
    end
    respond_to do |format|
      format.js { render :query }
    end
  end
end
