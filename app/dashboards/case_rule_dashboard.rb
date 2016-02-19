require "administrate/base_dashboard"

class CaseRuleDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    case: Field::BelongsTo,
    rule: Field::BelongsTo,
    case_rule_counts: Field::HasMany,
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    rule_order: Field::Number,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :case,
    :rule,
    :case_rule_counts,
    :id,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :case,
    :rule,
    :case_rule_counts,
    :id,
    :created_at,
    :updated_at,
    :rule_order,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :case,
    :rule,
    :case_rule_counts,
    :rule_order,
  ]

  # Overwrite this method to customize how case rules are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(case_rule)
  #   "CaseRule ##{case_rule.id}"
  # end
end
