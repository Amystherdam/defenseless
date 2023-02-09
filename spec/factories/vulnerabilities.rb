FactoryBot.define do
  factory :vulnerability do
    name { 'Vulnerabilidade' }
    description { 'Vulnerabilidade aleatória' }
    impact { 1 }
    solution { 'Solução da Vulnerabilidade' }
    status { 1 }
    user
  end
end
