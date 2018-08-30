class Matt < Caretaker
  class << self
    def find
      self.where(first_name: "Matthew", last_name: "Hummer").first
    end
    def create
      return self.find unless self.find.present?
      return Caretaker.create({
        first_name: "Matthew",
        last_name:  "Hummer",
        email:      "matt@example.com",
        password:   "password",
        master:     "true"
      })
    end
  end
end
