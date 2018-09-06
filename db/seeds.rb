Caretaker.destroy_all
Caretaker.create([
  {
    first_name: "Matthew",
    last_name:  "Hummer",
    email:      "matt@example.com",
    password:   "password",
    master:     "true"
  }]).each{|c| puts "Created Caretaker: #{c}"}

Client.destroy_all
Client.create([
  {
    first_name: "Annie",
    last_initial: "G",
    dob: 24.years.ago.to_s,
    addr1: "421 Cherry Street",
    addr2: nil,
    town: "Fort Collins",
    state: "CO",
    description: "Annie is a genuine sweetheart.",
    services_needed: "Hugs on the Daily.",
    ideal_providor: "He has red hair and super huge miscles.",
    important_to_me: "Someone who can provide plenty of donuts.",
    important_for_me: "Reminding me that it's not good to eat too many donuts.",
    additional_info: nil,
    shine_services: "She needs a lot of help when it comes to getting to places on time.",
    photo_url: '/system/photos/chickpic.jpg'
  },
  {
    first_name: "Benjamin",
    last_initial: "D",
    dob: 69.years.ago.to_s,
    addr1: "PO Box 69",
    addr2: "69 Partee Court",
    town: "Wellington",
    state: "CO",
    description: "Benjamin is a normal guy. He likes to be a normal guy.",
    services_needed: "Help putting his pants on.",
    ideal_providor: "Someone who is patient and not scared to see too much plumber's crack.",
    important_to_me: nil,
    important_for_me: nil,
    additional_info: nil,
    shine_services: nil,
    photo_url: '/system/photos/chickpic.jpg'
  },
  {
    first_name: "Ardy",
    last_initial: "R",
    dob: Date.parse('27.06.2018').to_s,
    addr1: "Po Box 1",
    addr2: "123 Sesame Street",
    town: "Fort Collins",
    state: "CO",
    description: "Ardy is a man born on a special day.",
    services_needed: "He doesn't need a whole lot of services",
    ideal_providor: "Someone loving.",
    important_to_me: nil,
    important_for_me: nil,
    additional_info: nil,
    shine_services: nil,
    photo_url: '/system/photos/chickpic.jpg'
  }
  ]).each{|c| puts "Created Client: #{c}"}
