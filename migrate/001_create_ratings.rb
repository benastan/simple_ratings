Sequel.migration do
  up do
    create_table(:ratings) do
      primary_key :id
      String :venue_id, null: false
      Integer :user_id, null: false
      Integer :stars, null: false
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:ratings)
  end
end