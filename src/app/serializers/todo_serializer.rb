# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  detail     :text
#  done       :boolean          default(FALSE), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TodoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :detail, :done
end
