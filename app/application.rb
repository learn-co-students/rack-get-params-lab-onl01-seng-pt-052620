class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = [] 

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty? 
        resp.write "Your cart is empty"
      else 
        @@cart.each do |item|
          resp.write "#{item}\n"
        end 
      end   
    elsif req.path.match(/add/)
      item = req.params["item"]
        if @@items.include?(item)
          @@cart << item 
          resp.write "added #{item}"
        else  
        resp.write "We don't have that item" 
      end 
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end


# 1) Shopping Cart Rack App /add Will add an item that is in the @@items list
#      Failure/Error: expect(last_response.body).to include("added Figs")
#        expected "We don't have that item" to include "added Figs"
     # ./spec/rack_mechanics_spec.rb:26:in `block (3 levels) in <top (required)>' 


# class Application 
#   @@items = ["Apples", "Carrots", "Pears"]

#   def call(env)
#     resp = Rack::Response.new 
#     req = Rack::Request.new(env)

#     if req.path.match(/items/)
#       @@items.each do |item|
#         resp.write "#{item}\n"
#       end 
#     elsif req.path.match(/search/)
#       search_term = req.params["q"]
#       if @@items.include?(search_term)
#         resp.write "#{seach_term} is one of our items"
#       else 
#         resp.write "Couldn't find #{search_term}"
#       end
#     else 
#       resp.write "Path Not Found" 
#     end
#     resp.finish  
#   end 
# end 