user_data = Faker::Internet.user #=> { username: 'alexie', email: 'alexie@example.net' }

user = User.create(
  email: user_data[:email],
  password: '12345678',
  name: user_data[:username]
)

Vulnerability.create(
  name: 'Vulnerabilidade',
  description: 'Vulnerabilidade aleatória',
  impact: Vulnerability.impacts[:low],
  solution: '',
  status: Vulnerability.statuses[:identified],
  user:
)
