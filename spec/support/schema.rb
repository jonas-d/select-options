ActiveRecord::Schema.define do
  self.verbose = false

  create_table :buckets, :force => true do |t|
    t.string :caption
  end
  create_table :marbles, :force => true

  create_table :bucket_marbles, :force => true do |t|
    t.references :bucket
    t.references :marble
  end


  create_table :groups, :force => true
  create_table :users, :force => true do |t|
    t.string :name
  end

  create_table :group_users, :force => true do |t|
    t.references :group, :polymorphic => true
    t.references :user
  end

  create_table :certificates, :force => true

  create_table :entity_certificates, :force => true do |t|
    t.references :entity, :polymorphic => true
    t.references :certificate
  end

end