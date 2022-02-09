class WalletsController < ApplicationController
  def index
    @wallets = ScrapableAddress.all
    render :index
  end

  def show
    @wallet = ScrapableAddress.find(params[:id])
    @wallet_transactions = Transaction.by_wallet(@wallet.address)
    @internal_transactions = InternalTransaction.by_wallet(@wallet.address)
    @erc20_inflows = Erc20Transaction.inflows(@wallet.address)
    @erc20_outflows = Erc20Transaction.outflows(@wallet.address)
    render :show
  end
end
