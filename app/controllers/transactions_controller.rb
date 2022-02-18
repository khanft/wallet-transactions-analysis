class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
    respond_to do |format| 
      format.html { render :index }
      format.csv { send_data @transactions.generate_csv, filename: "transactions-#{Date.today}.csv"}
    end
  end
  def update
    @transaction = Transaction.find(params[:id])
    Category.where(id: params[:transaction][:category_ids]).where.not(id: @transaction.categories.map(&:id)).each do |category|
      @transaction.categories << category
    end
    respond_to do |format| 
      format.js { render :update }
    end
  end
end
