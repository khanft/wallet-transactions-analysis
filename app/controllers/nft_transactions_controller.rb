class NftTransactionsController < ApplicationController
  def index
    @transactions = NftTransaction.all
    respond_to do |format| 
      format.html { render :index }
      format.csv { send_data @transactions.generate_csv, filename: "transactions-#{Date.today}.csv"}
    end
  end
end
