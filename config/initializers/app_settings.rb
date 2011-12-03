class AppSettings
  TROPO_VOICE_TOKEN = '0aea7b7daf76b648812c2e969fce1248773e465545109ccabda0da94971aaca1de39411e044b66f296f323f8'
  TROPO_MESSAGING_TOKEN = '0aea84142ecd0945a945eebd7c4736b3f4bcea736a62f01af34b10cd0b6506f1a4952e1b35dc3c7cb2fabc97'
  TROPO_API = 'http://api.tropo.com/1.0/sessions'

  CALL_TYPE = { 
    :sms                => 'sms',
    :voice              => 'voice',
    :conference         => 'conference',
    :greeter            => 'greeter',
    :greeter_conference => 'greeter_conference' 
  }
end
