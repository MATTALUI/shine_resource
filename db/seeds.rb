Organization.destroy_all
Organization.without_auditing do
  Organization.create([
    {
      name: " Test Shine"
    }
    ]).each{|o| puts "Created Organization: #{o} (#{o.id})"}
end
shine = Organization.first

Caretaker.destroy_all
Caretaker.without_auditing do
  Caretaker.create([
    {
      first_name:      "Matthew",
      last_name:       "Hummer",
      email:           "matt@example.com",
      password:        "password",
      master:          true,
      organization_id: shine.id
    }]).each{|c| puts "Created Caretaker: #{c} (#{c.id})"}
end
matt = Matt.find

Client.destroy_all
Client.without_auditing do
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
      ideal_provider: "He has red hair and super huge miscles.",
      important_to_me: "Someone who can provide plenty of donuts.",
      important_for_me: "Reminding me that it's not good to eat too many donuts.",
      additional_info: nil,
      shine_services: "She needs a lot of help when it comes to getting to places on time.",
      photo_url: DEFAULT_PHOTO
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
      ideal_provider: "Someone who is patient and not scared to see too much plumber's crack.",
      important_to_me: nil,
      important_for_me: nil,
      additional_info: nil,
      shine_services: nil,
      photo_url: DEFAULT_PHOTO
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
      ideal_provider: "Someone loving.",
      important_to_me: nil,
      important_for_me: nil,
      additional_info: nil,
      shine_services: nil,
      photo_url: DEFAULT_PHOTO
    },
    {
      first_name: "Test",
      last_initial: "M",
      dob: Date.parse('27.06.2018').to_s,
      addr1: "Po Box 1",
      addr2: "123 Sesame Street",
      town: "Fort Collins",
      state: "CO",
      description: "A place for the description of the client.",
      services_needed: "A place for the services needed for a client.",
      ideal_provider: "A place for the descriptions of an ideal provider.",
      important_to_me: "Things that are important to me.",
      important_for_me: "Things that are important for me.",
      additional_info: "Additional information about me.",
      shine_services: "Description of Shine Services that are needed.",
      photo_url: DEFAULT_PHOTO
    }
    ])
    .each{|c| c.organization = shine; c.save }
    .each{|c| puts "Created Client: #{c} (#{c.id})"}
end
c = Client.last

Memo.destroy_all
Memo.without_auditing do
  Memo.create([
    {
    client_id: c.id,
    caretaker_id: matt.id,
    body: "#{c} was okay today."},
    {
    client_id: c.id,
    caretaker_id: matt.id,
    body: "#{c} had some behavioral issues today."
    }
    ]).each{|m| puts "#{m.caretaker} made a note about #{m.client} (#{m.id})"}

  services = ["I helped take care of them.", "We went to the park."]
  interactions = ["Talked with cashier", "Interacted with group"]
  NoteGroup.destroy_all
  Note.destroy_all
  (1..3).each do |i|
    rand_time = [*1..4].sample
    ng = NoteGroup.create({
      caretaker_id: matt.id,
      start_time: rand_time.hours.ago,
      end_time: rand_time.hours.from_now,
      date: i.days.ago,
      total_hours: (rand_time*2),
      miles: ([*10..20].sample),
      billed_for: false
    })
    puts "Created NoteGroup (#{ng.id})"
    Client.all.limit([*1..Client.count].sample).each do |client|
      n = Note.create({
        client_id: client.id,
        start_time: ng.start_time,
        end_time: ng.end_time,
        service_description: services.sample,
        transportation_trips: [*1..3].sample,
        location: "Fort Collins",
        interactions: interactions.sample,
        support_provided: services.sample,
        comments: services.sample,
        note_group_id: ng.id
      })
      puts "----Created Note (#{n.id}) for #{client} (#{client.id})"
    end
  end
end
ActiveRecord::Base.connection.execute("delete from audits;")
puts "Cleared all audit data."
