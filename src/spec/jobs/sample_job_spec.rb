require 'rails_helper'

RSpec.describe SampleJob do
  describe 'perform' do
    it 'return 200' do
      VCR.use_cassette 'jobs/sample_job' do
        res = described_class.perform_now
        expect(res).to eq '200'
      end
    end
  end
end
