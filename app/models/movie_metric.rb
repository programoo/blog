class MovieMetric < ApplicationRecord
    belongs_to :movie, touch: true
end
