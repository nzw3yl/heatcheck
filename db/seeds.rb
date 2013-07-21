# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Provider.attr_accessible :provider_id
User.attr_accessible :provider_id
Partner.attr_accessible :provider_id
Customer.attr_accessible :provider_id
Measure.attr_accessible :provider_id
Contract.attr_accessible :provider_id
Contact.attr_accessible :provider_id, :contactable_id, :contactable_type

puts 'creating ROLES' 
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role 
end
puts 'creating admin user account'
admin_user = User.find_or_create_by_email(
  :first_name => ENV['ADMIN_FIRST_NAME'].dup, 
  :last_name => ENV['ADMIN_LAST_NAME'].dup,
  :email => ENV['ADMIN_EMAIL'].dup, 
  :password => ENV['ADMIN_PASSWORD'].dup, 
  :password_confirmation => ENV['ADMIN_PASSWORD'].dup,
)
admin_user.confirm!
puts 'user: ' << admin_user.email
puts 'provider_id: ' << admin_user.provider_id
admin_user.add_role :admin

puts 'creating Providers'
provider1 = Provider.new(
    :name                 => "demo provider",
    :description          => "demonstration company",
    :creator_id          => admin_user.id
)
provider1.save!
puts 'provider: ' << provider1.name

provider2 = Provider.new(
    :name                 => "test provider",
    :description          => "test company",
    :creator_id          => admin_user.id
)
provider2.save!
puts 'provider: ' << provider2.name

puts 'creating Users'
user1 = User.new(
    :email                 => "demo_user@example.com",
    :first_name            => "user",
    :last_name             => "demo_user",
    :password              => "changeme",
    :password_confirmation => "changeme",
    :provider_id           => provider1.id
)
user1.save!
user1.confirm!
user1.add_role :reviewer
puts 'user: ' << user1.email

user2 = User.new(
    :email                 => "demo_vip@example.com",
    :first_name            => "vip",
    :last_name             => "demo_user",
    :password              => "changeme",
    :password_confirmation => "changeme",
    :provider_id           => provider1.id
)
user2.save!
user2.confirm!
user2.add_role :VIP
puts 'user: ' << user2.email

user3 = User.new(
    :email                 => "demo_manager@example.com",
    :first_name            => "admin",
    :last_name             => "demo_user",
    :password              => "changeme",
    :password_confirmation => "changeme",
    :provider_id           => provider1.id
)
user3.save!
user3.confirm!
user3.add_role :manager
puts 'user: ' << user3.email

user4 = User.new(
    :email                 => "test_user@example.com",
    :first_name            => "user",
    :last_name             => "test_user",
    :password              => "changeme",
    :password_confirmation => "changeme",
    :provider_id           => provider2.id
)
user4.save!
user4.confirm!
user4.add_role :reviewer
puts 'user: ' << user4.email

user5 = User.new(
    :email                 => "test_vip@example.com",
    :first_name            => "vip",
    :last_name             => "test_user",
    :password              => "changeme",
    :password_confirmation => "changeme",
    :provider_id           => provider2.id
)
user5.save!
user5.confirm!
user5.add_role :VIP
puts 'user: ' << user5.email

user6 = User.new(
    :email                 => "test_manager@example.com",
    :first_name            => "admin",
    :last_name             => "test_user",
    :password              => "changeme",
    :password_confirmation => "changeme",
    :provider_id           => provider2.id
)
user6.save!
user6.confirm!
user6.add_role :manager
puts 'user: ' << user6.email

puts 'creating Partners'
partner1 = Partner.new(
  :name                    => "demo partner",
  :description             => "demonstration partner",
  :provider_id             => provider1.id
)
partner1.save!
puts 'partner: ' << partner1.name

partner2 = Partner.new(
  :name                    => "test partner",
  :description             => "test partner",
  :provider_id             => provider2.id
)
partner2.save!
puts 'partner: ' << partner2.name

puts 'creating Customers'
customer1 = Customer.new(
  :name                    => "demo customer",
  :short_name              => "dem",
  :description             => "demonstration customer",
  :provider_id             => provider1.id
)
customer1.save!
puts 'customer: ' << customer1.name

customer2 = Customer.new(
  :name                    => "test customer",
  :short_name              => "tst",
  :description             => "test customer",
  :provider_id             => provider2.id
)
customer2.save!
puts 'customer: ' << customer2.name

puts 'creating demo and test Contracts'
Contract.create!([
  {
    :partner_id              => partner1.id,
    :customer_id             => customer1.id,
    :expiry_date             => DateTime.new(2015,1,7),
    :start_date              => DateTime.new(2013,1,7),
    :notes                   => "demo contract note",
    :provider_id             => provider1.id
  },
  {
    :partner_id              => partner2.id,
    :customer_id             => customer2.id,
    :expiry_date             => DateTime.new(2015,2,7),
    :start_date              => DateTime.new(2013,2,7),
    :notes                   => "test contract note",
    :provider_id             => provider2.id
  }
])

puts 'creating demo and test Contacts --- no R '
Contact.create!([
  {
    :name                 => "Demo Provider Contact",
    :title                => "Provider Manager",
    :team                 => "Sales",
    :contactable_id       => provider1.id,
    :contactable_type     => "Provider",
    :provider_id          => provider1.id  
  },
  {
    :name                 => "Demo Partner Contact",
    :title                => "Partner Manager",
    :team                 => "Sales",
    :contactable_id       => partner1.id,
    :contactable_type     => "Partner",
    :provider_id          => provider1.id 
  },
  {
    :name                 => "Demo Customer Contact",
    :title                => "Customer Manager",
    :team                 => "Operations",
    :contactable_id       => customer1.id,
    :contactable_type     => "Customer",
    :provider_id          => provider1.id
  },
  {
    :name                 => "Test Provider Contact",
    :title                => "Provider Manager",
    :team                 => "Sales",
    :contactable_id       => provider2.id,
    :contactable_type     => "Provider",
    :provider_id          => provider2.id  
  },
  {
    :name                 => "Test Partner Contact",
    :title                => "Partner Manager",
    :team                 => "Sales",
    :contactable_id       => partner2.id,
    :contactable_type     => "Partner",
    :provider_id          => provider2.id  
  },
  {
    :name                 => "Test Customer Contact",
    :title                => "Customer Manager",
    :team                 => "Operations",
    :contactable_id       => customer2.id,
    :contactable_type     => "Customer",
    :provider_id          => provider2.id
  } 
])

puts 'creating Measures'
Measure.create!([
  {
    :content              => "System Performance",
    :provider_id          => provider1.id
  },
  {
    :content              => "Helpdesk Quality",
    :provider_id          => provider1.id
  },
  {
    :content              => "System Performance",
    :provider_id          => provider2.id
  },
  {
    :content              => "Helpdesk Quality",
    :provider_id          => provider2.id
  }
])
