class Erc20TransactionsController < ApplicationController
  def index
    @transactions = Erc20Transaction.all
    respond_to do |format| 
      format.html { render :index }
      format.csv { send_data @transactions.generate_csv, filename: "erc20-transactions-#{Date.today}.csv"}
    end
  end
end
