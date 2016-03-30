require "administrate/base_dashboard"

class BoardMemberDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    cases: Field::HasMany,
    board_member_votes: Field::HasMany,
    terms: Field::HasMany,
    id: Field::Number,
    first_name: Field::String,
    last_name: Field::String,
    board_position: Field::String,
    job_title: Field::String,
    organization: Field::String,
    facebook_handle: Field::String,
    twitter_handle: Field::String,
    linkedin_handle: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime    
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :first_name,
	:last_name,
    :updated_at
    #:cases,
    #:board_member_votes,
    #:terms,
    #:id,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    #:cases,
    #:board_member_votes,
    :id,
    :first_name,
    :last_name,
    :board_position,
    :job_title,
    :organization,
    :facebook_handle,
    :twitter_handle,
    :linkedin_handle,
    :created_at,
    :updated_at,
    :terms,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    #:cases,
    #:board_member_votes,
    :first_name,
    :last_name,
    :board_position,
    :job_title,
    :organization,
    :facebook_handle,
    :twitter_handle,
    :linkedin_handle,
    :terms,
  ]

  # Overwrite this method to customize how board members are displayed
  # across all pages of the admin dashboard.
  #
   def display_resource(board_member)
     #"BoardMember ##{board_member.id}"
	 "#{board_member.first_name} #{board_member.last_name}"
   end
end
