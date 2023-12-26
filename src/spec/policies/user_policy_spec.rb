require 'rails_helper'

# rubocop:disable RSpec/RepeatedExampleGroupBody
RSpec.describe UserPolicy, type: :policy do
  let!(:user) { FactoryBot.create(:user) }
  let!(:record) { user } # rubocop:disable RSpec/LetSetup
  let!(:context) { { user: } } # rubocop:disable RSpec/LetSetup

  describe_rule :index? do
    succeed 'when user is system'

    succeed 'when user is admin' do
      before { user.role = :admin }
    end

    succeed 'when user is normal' do
      before { user.role = :normal }
    end
  end

  describe_rule :show? do
    succeed 'when user is system'

    succeed 'when user is admin' do
      before { user.role = :admin }
    end

    succeed 'when user is normal' do
      before { user.role = :normal }
    end
  end

  describe_rule :create? do
    succeed 'when user is system'

    succeed 'when user is admin' do
      before { user.role = :admin }
    end

    succeed 'when user is normal' do
      before { user.role = :normal }
    end
  end

  describe_rule :edit? do
    succeed 'when user is system'

    succeed 'when user is admin' do
      before { user.role = :admin }

      failed 'when user is admin and willing to change other' do
        let(:record) { FactoryBot.create(:user) }
      end
    end

    succeed 'when user is normal' do
      before { user.role = :normal }

      failed 'when user is admin and willing to change other' do
        let(:record) { FactoryBot.create(:user) }
      end
    end
  end
end
# rubocop:enable RSpec/RepeatedExampleGroupBody
