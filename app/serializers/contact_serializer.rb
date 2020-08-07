class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate
  
  has_one  :address

  belongs_to :kind do 
    link(:related) { contact_kind_url(object.id) }
  end

  has_many :phones do
    link(:related) { contact_phones_url(object.id) }
  end

  meta do 
    { 
      author: :Doug 
    }
  end

end
