if User.count.zero?
  User.create(
    email: 'john.doe@mail.com',
    password: 'password',
    password_confirmation: 'password'
  )
end
