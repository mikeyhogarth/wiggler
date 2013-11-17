def login_as(scope)
  user = create(scope)
  sign_in user
end

