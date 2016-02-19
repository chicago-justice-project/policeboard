require "administrate/base_dashboard"

class CaseDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    defendant: Field::BelongsTo,
    recommended_outcome: Field::BelongsTo.with_options(class_name: "Outcome"),
    decided_outcome: Field::BelongsTo.with_options(class_name: "Outcome"),
    board_member_votes: Field::HasMany,
    case_rules: Field::HasMany,
    case_rule_counts: Field::HasMany,
    complaints: Field::HasMany,
    id: Field::Number,
    number: Field::String,
    date_initiated: Field::DateTime,
    date_decided: Field::DateTime,
    recommended_outcome_id: Field::Number,
    decided_outcome_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :defendant,
    :recommended_outcome,
    :decided_outcome,
    :board_member_votes,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :defendant,
    :recommended_outcome,
    :decided_outcome,
    :board_member_votes,
    :case_rules,
    :case_rule_counts,
    :complaints,
    :id,
    :number,
    :date_initiated,
    :date_decided,
    :recommended_outcome_id,
    :decided_outcome_id,
    :created_at,
    :updated_at,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :defendant,
    :recommended_outcome,
    :decided_outcome,
    :board_member_votes,
    :case_rules,
    :case_rule_counts,
    :complaints,
    :number,
    :date_initiated,
    :date_decided,
    :recommended_outcome_id,
    :decided_outcome_id,
  ]

  # Overwrite this method to customize how cases are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(case)
  #   "Case ##{case.id}"
  # end
end
