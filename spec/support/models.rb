class Marble < ActiveRecord::Base
  has_one :bucket_marble
  has_one :bucket, :through => :bucket_marble
  # has_one :financial_model, :through => :model_item, :source => :model, :source_type => "FinancialModel"
  # has_one :business_model, :through => :model_item, :source => :model, :source_type => "BusinessModel"
end

class Bucket < ActiveRecord::Base
  has_many :bucket_marbles
  has_many :marbles, :through => :bucket_marbles
end

class BucketMarble < ActiveRecord::Base
  # belongs_to :bucket, :polymorphic => true  # polymorphic STI association
  belongs_to :bucket
  belongs_to :marble
end


class User < ActiveRecord::Base
  has_one :group_user
  has_one :group, :through => :group_user, :source_type => "Group"  # source_type is required!
end

class Group < ActiveRecord::Base ; end
class Admin < Group ; end
class Expert < Group ; end

class GroupUser < ActiveRecord::Base
  belongs_to :group, :polymorphic => true
  belongs_to :user
end