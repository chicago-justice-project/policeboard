require "administrate/fields/base"

class PasswordField < Administrate::Field::Base
  def to_s
    #data -- we don't want to display the password
  end
end
