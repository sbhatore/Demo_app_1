class AddAppendSecureController < ApplicationController
	def append
  end

  def add
  end

  def view_appended
    cookies.signed.tap do |c|
    	key = "appended_secure"
    	purpose = "Append"
    	if c[key]
    		if c[key].split(".")[1] != purpose
     			raise "You are misusing your cookie. To resolve this, delete the cookie you have in your browser
     			related to this page"    			
    		end
    		if c[key]
        	c[key] = c[key].split(".")[0] << (params[:input].to_s) << "." << purpose
        end
    	else
      	c[key] = params[:input].to_s << "." << purpose
    	end
    	if c[key]
    		@appended_secure = c[key].split(".")[0].to_i
    	end
    end
  end

  def view_added
    cookies.signed.tap do |c|
    	key = "added_secure"
    	purpose = "Add"
      if c[key]
    		if c[key].split(".")[1] != purpose
     			raise "You are misusing your cookie. To resolve this, delete the cookie you have in your browser
     			related to this page"    			
    		end
        c[key] = (c[key].split(".")[0].to_i + params[:input].to_i).to_s << "." << purpose
    	else
      	c[key] = params[:input].to_s << "." << purpose
    	end
    	@added_secure = c[key].split(".")[0].to_i
    end
  end
end
