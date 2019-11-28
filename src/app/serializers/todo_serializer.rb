class TodoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :detail, :done
end
