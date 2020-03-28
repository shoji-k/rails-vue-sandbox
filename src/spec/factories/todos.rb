# == Schema Information
#
# Table name: todos
#
#  id         :bigint           not null, primary key
#  detail     :text
#  done       :boolean          default("false"), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :todo do
    sequence(:title) { |n| "title #{n}" }
    sequence(:detail) { |n| "detail #{n}" }
    done { false }
  end
end
