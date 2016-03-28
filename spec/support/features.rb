module Features
  include Features::Client
  include Features::SignIn
  include Features::SignOut
  include Features::SignUp
  include Features::User
  include Features::UserToken
  include Features::Test::Database
  include Features::Test::User
  include Features::Token
end
