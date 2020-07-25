namespace :dev do
  desc "Setup development environment"
  task setup: :environment do
    %x(rails db:drop db:create db:migrate)

    kinds = %w(Friend Comercial Colegue)

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end

    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(:from => 65.years.ago, :to => 18.years.ago),
        kind: Kind.all.sample
      )
    end

    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = Phone.create!(
          number: Faker::PhoneNumber.cell_phone,
          contact: contact
        )

        contact.phones << phone
        contact.save!
      end
      
      Address.create!(
        street: Faker::Address.street_name,
        city: Faker::Address.city,
        contact: contact
      )
    end

  end

end
