class User < ApplicationRecord
  has_secure_password #password hashing
  ROLES = [['Admin', :admin],['Instructor', :instructor],['Parent', :parent]]
  # relationships

  # validations
  validates_presence_of :username, :password_digest, :role, :email
  validates :role, inclusion: { in: %w[admin instructor parent], message: "is not in system" }
  validates_length_of :password_digest, minimum: 4
  validates :password_digest, confirmation: { case_sensitive: false }  
  
  #validates_format_of :phone, with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/
  validates :phone, format: { with: /\A[0-9,;,:.\-\)\(]+\z/}
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil))\z/i
  
  #validates_length_of :password, minimum: 4
  #validates :password, confirmation: { case_sensitive: false }

  # unique
  validates :username, uniqueness: {case_sensitive: false} 
  #validates :email, uniqueness: {case_sensitive: false}    

end
