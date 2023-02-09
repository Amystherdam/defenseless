FactoryBot.define do
  factory :vulnerability do
    name { 'Vulnerabilidade' }
    description { 'Vulnerabilidade aleatória' }
    impact { 0 }
    solution { 'Solução da Vulnerabilidade' }
    status { 0 }
    user
  end
end
