class Marble < ActiveRecord::Base
  has_one :bucket_marble
  has_one :bucket, :through => :bucket_marble
end

class Bucket < ActiveRecord::Base
  has_many :bucket_marbles
  has_many :marbles, :through => :bucket_marbles

  has_one :entity_certificate, :as => :entity
  has_one :certificate, :through => :entity_certificate
end

class BucketMarble < ActiveRecord::Base
  belongs_to :bucket
  belongs_to :marble
end


class User < ActiveRecord::Base
  has_one :group_user
  has_one :group, :through => :group_user, :source_type => "Group"  # source_type is required!

  has_one :entity_certificate, :as => :entity
  has_one :certificate, :through => :entity_certificate
end

class Group < ActiveRecord::Base ; end
class Admin < Group ; end
class Expert < Group ; end

class GroupUser < ActiveRecord::Base
  belongs_to :group, :polymorphic => true
  belongs_to :user
end


class Certificate < ActiveRecord::Base
  has_one :entity_certificate
  has_one :entity, :through => :entity_certificate, :source_type => "ActiveRecord::Base"
end

class EntityCertificate < ActiveRecord::Base
  belongs_to :certificate
  belongs_to :entity, :polymorphic => true
end
