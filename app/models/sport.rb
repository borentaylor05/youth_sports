class Sport < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 100 }
	validates :season_start, presence: true
	validates :season_end, presence: true
	validates :open_to, presence: true, inclusion: ['boys', 'girls', 'both']
	validates :coed, inclusion: [true, false]
	validates :min_age, presence: true
	validates :max_age, presence: true
end
