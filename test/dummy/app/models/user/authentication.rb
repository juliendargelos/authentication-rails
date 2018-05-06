class User::Authentication < Authentication::Base
  has_model :user
  has_public :email
  has_private :password
end
