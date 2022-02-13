class InternalTransactionsController < ApplicationController
  def index
    @transactions = InternalTransaction.all
    respond_to do |format| 
      format.html { render :index }
      format.csv { send_data @transactions.generate_csv, filename: "internal-transactions-#{Date.today}.csv"}
    end
  end
end
