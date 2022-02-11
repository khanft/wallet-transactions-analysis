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
    @grouped_by_erc20 = Erc20Transaction.grouped_by_erc20(@wallet.address)
    @weth_unwrapped = Erc20Transaction.synthetic_weth_outflows @wallet.address 
    @weth_wrapped = Erc20Transaction.synthetic_weth_inflows @wallet.address
    render :show
  end
end
