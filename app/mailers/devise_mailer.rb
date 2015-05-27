class DeviseMailer < Devise::Mailer
  def confirmation_instructions(record,token, opts={}) 
    opts[:subject] = "Welcome to Beacon! - Verification Email"
    super
  end
end