# == Schema Information
#
# Table name: todos
#
#  id         :bigint           not null, primary key
#  detail     :text
#  done       :boolean          default(FALSE), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Todo do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
