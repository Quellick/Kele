require 'httparty'

class kele
  include httparty
  base_url 'https://www.bloc.io/api/v1'

  def initialize(email,password)
    response = self.class.post('/sessions', body: {
      "email": email,
      "password": password
    })
    puts response.code
    raise "Invalid Email or Password. Please Try Again." if response.code == 404
    @auth_token = response["auth_token"]
  end
end
