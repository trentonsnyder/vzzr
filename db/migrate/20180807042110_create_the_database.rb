class CreateTheDatabase < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name, default: ''
      t.string :kind, null: false
      t.string :cover_image_url, default: ''
      t.text :description, default: ''
    end

    create_table :genres do |t|
      t.string :name, null: false
    end

    create_table :videos do |t|
      t.string :url, null: false
      t.string :name, null: false
      t.string :thumbnail, default: ''
      t.text :description, default: ''
      t.belongs_to :genre, foreign_key: true
      t.belongs_to :company, foreign_key: true
    end
    
    create_table :views do |t|
      t.belongs_to :video, foreign_key: true
      t.jsonb :metadata, default: {}
      t.timestamps
    end

    create_table :conversations do |t|
    end

    create_table :messages do |t|
      t.text :body, null: false
      t.belongs_to :conversation, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :company, foreign_key: true
      t.boolean :read, default: false
      t.timestamps
    end

    create_table :participants do |t|
      t.belongs_to :conversation, foreign_key: true
      t.belongs_to :company, foreign_key: true
    end
  end
end
