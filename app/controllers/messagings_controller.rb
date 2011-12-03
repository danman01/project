class MessagingsController < ApplicationController
  def index
      #initial_text captures the very first sms or IM sent to tropo
      initial_text = params["session"]["initialText"]
      from = params["session"]["from"]
      network = from["network"]
      from_id = from["id"] # this field contains IM login or phone number in case of incoming SMS
      if network == "SMS" || network == "JABBER"
        render :json => parse(initial_text)
      else
        render :json => Tropo::Generator.say("Unsupported operation")
      end
    end

    private

    def parse(input)
      input.strip!
      # do whatever parsing you need.  in this example, if user types "n what a new day", tropo will
      # respond him with "you said: what a new day"
      if m = input.match(/^(n|N)\s+/)
        Tropo::Generator.say "you said: " + m.post_match
      else
        Tropo::Generator.say "Unsupported operation."
      end
    end
    
    # Process an SMS message request from Tropo
     def sms
       values = params[:session][:parameters]
       request_token = values[:token]
       request_user = values[:user_id]
       request_ticket = values[:ticket_id]

       # Generate Tropo response 
       t = Tropo::Generator.new
       t.call(:to => '+18005555432', :network => "SMS")
       t.say(:value => "Could this actually work??! user=#{request_user}, ticket=#{request_ticket}")
       tropo_message = t.response

       respond_to do |format|
         format.html  { redirect_to root_path }
         format.json  { render :json => tropo_message }
       end
     end
     
     def voice
       logger.info "\n\n tropo response: #{params[:session][:parameters]} \n\n"
        values = params[:session][:parameters]
        request_token = values[:token]
        request_user = values[:user_id]
        request_ticket = values[:ticket_id]

        # Generate Tropo response 
        t = Tropo::Generator.new
        t.call(:to => '+16786434429', :from => "+14048574679")
        t.say(:value => "Could this actually work??!")
        tropo_message = t.response
        flash[:message] = "coming from a call..."
        logger.error "?"*80
        logger.error "create.json: #{t.response}"
        logger.error "?"*80
        respond_to do |format|
          format.html  { redirect_to "/home/index" }
          format.json  { render :json => tropo_message }
        end
      end
end
