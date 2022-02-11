module WalletsHelper
  def wallet_resolver(wallets, address)
    wallets.each do |w|
      if w.address.downcase == address
        return w.name
      end
    end
    return address
  end
end
