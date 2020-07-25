class Contact < ApplicationRecord
    belongs_to :kind, optional: true
    has_many   :phones
    has_one    :address
    
    accepts_nested_attributes_for :phones, allow_destroy: true
    accepts_nested_attributes_for :address, update_only: true

    def kind_description
        self.kind != nil ? self.kind.description : ""
    end

    # After adding AMS with JSON:API specification, this method is not used anymore
    def as_json(options={})
        super(
            root: true,
            include: { 
                kind: { only: :description }, 
                phones: {},
                address: { except: [:created_at, :updated_at] }
            },
            methods: [
                :kind_description, 
                :author
            ])
    end
end
