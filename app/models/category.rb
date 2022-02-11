class Category < ApplicationRecord

  def transactions
    transaction_ids = TransactionCategorization.where(category_id: self.id).where.not(transaction_id: nil).map &:transaction_id
    Transaction.where(id: transaction_ids).all
  end
end
