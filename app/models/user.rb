class User < ActiveRecord::Base

	DEFAULT_ROLE = :developer
	DEVELOPER_ROLE = :developer
  ADMIN_ROLE = :admin

  after_save :assign_default_role

  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_features
  has_many :logs
	has_many :features, through: :user_features

  def assign_default_role
    self.add_role(DEFAULT_ROLE) if self.roles.blank?
  end
end
