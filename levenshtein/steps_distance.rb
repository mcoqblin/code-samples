require 'feature_content_diff/feature_distance'
require 'feature_content_diff/string_distance'
require 'step'

module FeatureContentDiff
	class StepsDistance < FeatureDistance
		def initialize(compared_steps, reference_steps)
			@compared_steps = compared_steps
			@reference_steps = reference_steps
		end
		
		private
		
		def compute_distance
			levenshtein_distance_for_steps
		end
		
		def levenshtein_distance_for_steps
			return 0 if @compared_steps.map(&:text) == @reference_steps.map(&:text)
			
			s = @compared_steps
			t = @reference_steps
			
			m = s.length
			n = t.length
			
			return n if m == 0
			return m if n == 0
			
			v0 = (0..n).to_a
			v1 = Array.new(n+1)
			
			m.times do |i|
				v1[0] = i + 1
				
				n.times do |j|
					deletion_cost = v0[j+1] + 1
					insertion_cost = v1[j] + 1
					substitution_cost = v0[j] + (StringDistance.new(s[i].text, t[j].text).close? ? 0 : 1)
					
					v1[j+1] = [deletion_cost, insertion_cost, substitution_cost].min
				end
				
				v0 = v1.dup
			end
			
			v0[n]
		end
		
		def maximum_distance
			0
		end
	end
end
