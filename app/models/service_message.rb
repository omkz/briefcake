# frozen_string_literal: true

class ServiceMessage < ApplicationRecord
  self.primary_key = :id
  validates_presence_of :data, :service_type
end