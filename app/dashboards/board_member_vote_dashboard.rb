require "administrate/base_dashboard"

class BoardMemberVoteDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    case: Field::BelongsTo,
    board_member: Field::BelongsTo,
    vote: Field::BelongsTo,
    id: Field::Number,
    dissent_description: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :case,
    :board_member,
    :vote,
    :id,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :case,
    :board_member,
    :vote,
    :id,
    :dissent_description,
    :created_at,
    :updated_at,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :case,
    :board_member,
    :vote,
    :dissent_description,
  ]

  # Overwrite this method to customize how board member votes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(board_member_vote)
  #   "BoardMemberVote ##{board_member_vote.id}"
  # end
end
