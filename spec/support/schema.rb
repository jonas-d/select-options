ActiveRecord::Schema.define do
  self.verbose = false

  create_table :buckets, :force => true
  create_table :marbles, :force => true

  # single type association
  create_table :bucket_marbles, :force => true do |t|
    t.references :bucket
    t.references :marble
  end


  create_table :groups, :force => true
  create_table :users, :force => true

  # polymorphic association (pure STI)
  create_table :group_users, :force => true do |t|
    t.references :group, :polymorphic => true
    t.references :user
  end

  # (arbitrary) polymorphic association



end