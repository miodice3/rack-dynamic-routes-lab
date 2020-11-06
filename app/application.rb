require 'pry'

class Application

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        #binding.pry
        if req.path.match(/items/)
            item_name = req.path.split("/items/").last

            item = Item.all.collect do |i|
                 if i.name == item_name
                    i
                 end
            end
            #binding.pry
            
            if item.find{|s| item_name} == nil
                resp.write "Item not found"
                resp.status = 400
            elsif item.find{|s| item_name}
                resp.write item[0].price
            end

        else
            resp.write "Route not found"
            resp.status = 404
        end

        resp.finish
    end

end




# Your application should only accept the /items/&lt;ITEM NAME> route. Everything else should 404
# If a user requests /items/&lt;Item Name> it should return the price of that item
# IF a user requests an item that you don't have, then return a 400 and an error message
