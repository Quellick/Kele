module Roadmap
   def get_roadmap(roadmap_id)
       #use roadmap_id 38 for testing
     response = self.class.get("/roadmaps/#{roadmap_id}", headers: { "authorization" => @auth_token })
     @roadmap = JSON.parse(response.body)
   end
 
   def get_checkpoint(checkpoint_id)
       # use checkpoint_id 2299 for testing
     response = self.class.get("/checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token })
     @checkpoint = JSON.parse(response.body)
   end
end