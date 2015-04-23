object :@membership

extends 'people/person'

child(:person) do
  attribute :id
end

attributes :meta_data
