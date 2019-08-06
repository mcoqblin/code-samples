require 'feature_content_diff/steps_distance'

RSpec.describe FeatureContentDiff::StepsDistance do
	subject { FeatureContentDiff::StepsDistance.new(previous_steps, new_steps).distance }
	
	let(:previous_steps) {
		[previous_step_1, previous_step_2, previous_step_3]
	}
	
	let(:new_steps) {
		[new_step_1, new_step_2, new_step_3]
	}
	
	let(:previous_step_1) { Step.new('My very first step') }
	let(:previous_step_2) { Step.new('Your second step') }
	let(:previous_step_3) { Step.new('Surprise third step') }
	
	let(:new_step_1) { Step.new('My very first step') }
	let(:new_step_2) { Step.new('Your second step') }
	let(:new_step_3) { Step.new('Surprise third step') }
	
	context 'when all steps are the same' do
		it { is_expected.to eq 0 }
	end
	
	context 'when the new list has one less step' do
		let(:new_steps) {
			[new_step_1, new_step_2]
		}
		
		it { is_expected.to eq 1 }
	end
	
	context 'when the new list has one more step' do
		before do
			new_steps << Step.new('Yet another step')
		end
		
		it { is_expected.to eq 1 }
	end
	
	context 'when the new list has two more step' do
		before do
			new_steps << Step.new('Yet another step')
			new_steps << Step.new('And another one')
		end
		
		it { is_expected.to eq 2 }
	end
	
	context 'when a step is not at the same position' do
		let(:new_steps) {
			[new_step_1, new_step_3, new_step_2]
		}
		
		it { is_expected.to eq 2 }
	end
	
	context 'when a step has a close text' do
		let(:new_step_1) { Step.new('My very last step') }
		
		it { is_expected.to eq 0 }
	end
	
	context 'when a step has a different text' do
		let(:new_step_1) { Step.new('My super last step') }
		
		it { is_expected.to eq 1 }
	end
end
