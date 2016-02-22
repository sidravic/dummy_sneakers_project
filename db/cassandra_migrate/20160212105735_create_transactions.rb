class CreateTransactions < CassandraMigrations::Migration
  def up
    create_table(:transactions, partition_keys: [:id],
                                primary_keys: [:id, :event_id]) do |t|
      t.uuid      :id
      t.timeuuid  :event_id
      t.string    :status
      t.string    :user_id
      t.string    :merchant_id
      t.integer   :amount_in_paise
      t.text      :payload
    end

    create_index(:transactions, :status, name: 'transactions_status_index')
    create_index(:transactions, :merchant_id, name: 'transactions_merchant_id_index')
    create_index(:transactions, :user_id, name: 'transactions_user_index')
  end
  
  def down
    drop_index('transactions_status_index')
    drop_index('transactions_merchant_id_index')
    drop_index('transactions_user_index')
    drop_table(:transactions)
  end
end
