class Tv < ApplicationRecord
has_many :tvstreams
accepts_nested_attributes_for :tvstreams, allow_destroy: true

end
