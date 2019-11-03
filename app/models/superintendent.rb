class Superintendent < ActiveRecord::Base
    def photo
        superintendent_dir = "superintendents/"
        photo = [superintendent_dir, full_name.downcase.gsub(' ','-').gsub('.',''), ".png"].join
        File.exists?([Rails.root, "/app/assets/images/", photo].join) ? photo : "#{superintendent_dir}placeholder.jpg"
    end

    def full_name
        [first_name, last_name].join(' ')
    end
end
