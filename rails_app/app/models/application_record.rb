# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.ransackable_attributes(auth_object = nil)
    self.attribute_names
  end

  def self.ransackable_associations(auth_object = nil)
    self.reflect_on_all_associations.map(&:name).map(&:to_s)
  end
end
