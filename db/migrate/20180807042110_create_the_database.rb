class CreateTheDatabase < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name, default: ''
      t.string :kind, null: false
    end

    create_table :listings do |t|
      t.string :name, null: false
      t.text :description, default: ''
      t.string :thumbnail, default: ''
    end

    create_table :videos do |t|
      t.string :url, null: false
      t.belongs_to :listing, foreign_key: true
    end

    create_table :conversations do |t|
      t.bigint :user_1_id, foreign_key: true
      t.bigint :user_2_id, foreign_key: true
    end

    create_table :messages do |t|
      t.text :body, null: false
      t.belongs_to :user, foreign_key: true
      t.belongs_to :conversation, foreign_key: true
      t.timestamps
    end

    add_index :conversations, :user_1_id
    add_index :conversations, :user_2_id
    add_index :conversations, [:user_1_id, :user_2_id]
  end
end
