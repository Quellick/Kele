require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap
  base_uri 'https://www.bloc.io/api/v1'
  

  def initialize(email,password)
    response = self.class.post('/sessions', body: {
      "email": email,
      "password": password
    })
    raise "Invalid Email or Password. Please Try Again." if response.code == 404
    @auth_token = response["auth_token"]
    puts @auth_token
  end
  
  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end
  
  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end
  
  def get_messages(page_number=nil)
     if page_number == nil
       response = self.class.get("/message_threads", headers: { "authorization" => @auth_token })
     else
       response = self.class.get("/message_threads?page=#{page_number}", headers: { "authorization" => @auth_token })
     end
     @messages = JSON.parse(response.body)
  end
 
  def create_message(sender, recipient_id, token, subject, stripped_text)
    response = self.class.post("/messages",            # sender, recipient_id, and stripped text are required
      body: {
        "sender": sender,                               # my email
        "recipient_id": recipient_id,                   # id 2345139
        "token": token,                                 # message thread token or nil for new thread
        "subject": subject,                             # string
        "stripped_text": stripped_text                  # string
      },
      headers: { "authorization" => @auth_token, content_type: "application/json" })
    p response
    puts response.body
  end
  
  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
    response = self.class.post("https://www.bloc.io/api/v1/checkpoint_submissions", headers: { "authorization": @auth_token },
      body: {
        "assignment_branch": assignment_branch,
        "assignment_commit_link": assignment_commit_link,
        "checkpoint_id": checkpoint_id,
        "comment": comment,
        "enrollment_id": enrollment_id
      },
      headers: { "authorization" => @auth_token, content_type: "application/json" })
  end
  
  
end
