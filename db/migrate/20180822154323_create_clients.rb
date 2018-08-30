class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients, id: :uuid do |t|
      t.string  :first_name, null: false

      t.string  :last_initial, limit: 1, null: false

      t.string    :encrypted_dob
      t.string    :encrypted_dob_iv

      t.string  :encrypted_addr1
      t.string  :encrypted_addr1_iv

      t.string  :encrypted_addr2
      t.string  :encrypted_addr2_iv

      t.string  :town

      t.string  :state, limit: 2

      t.text    :encrypted_description
      t.text    :encrypted_description_iv

      t.text    :encrypted_services_needed
      t.text    :encrypted_services_needed_iv

      t.text    :encrypted_ideal_provider
      t.text    :encrypted_ideal_provider_iv

      t.text    :encrypted_important_to_me
      t.text    :encrypted_important_to_me_iv

      t.text    :encrypted_important_for_me
      t.text    :encrypted_important_for_me_iv

      t.text    :encrypted_additional_info
      t.text    :encrypted_additional_info_iv

      t.text    :encrypted_shine_services
      t.text    :encrypted_shine_services_iv

      t.string  :encrypted_photo_url
      t.string  :encrypted_photo_url_iv

      t.timestamps
    end
  end
end
