class ParentMailer < ApplicationMailer
  def welcome_email(parent_id)
    @parent = Parent.find(parent_id)
    mail(to: @parent.email, subject: "Welcome to Children's Council")
  end
end
