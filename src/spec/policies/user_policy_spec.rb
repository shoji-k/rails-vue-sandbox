require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:user) { FactoryBot.create(:user) }
  let(:record) { user }
  let(:context) { { user: user } }

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

    failed 'when user is admin' do
      before { user.role = :admin }
    end

    failed 'when user is normal' do
      before { user.role = :normal }
    end
  end

  describe_rule :update? do
    succeed 'when user is system'

    succeed 'when user is admin' do
      before { user.role = :admin }
    end

    succeed 'when user is normal' do
      before { user.role = :normal }
    end
  end

  describe_rule :destroy? do
    succeed 'when user is system'

    succeed 'when user is admin' do
      before { user.role = :admin }
    end

    succeed 'when user is normal' do
      before { user.role = :normal }
    end
  end
end
