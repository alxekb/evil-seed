# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveRecord::Schema.define(version: 0) do
  create_table :forums do |t|
    t.string :name
  end

  create_table :users do |t|
    t.string     :name
    t.string     :title
    t.references :forum, foreign_key: true
    t.timestamps null: false
  end

  create_table :questions do |t|
    t.references :forum, foreign_key: { on_delete: :cascade }
    t.string     :name
    t.integer    :rating, default: 0, null: false
    t.text       :text
    t.references :author, foreign_key: { to_table: :users, on_delete: :nullify }
  end

  create_table :answers do |t|
    t.references :question, foreign_key: { on_delete: :cascade }
    t.boolean    :best
    t.text       :text
    t.references :author, foreign_key: { to_table: :users, on_delete: :nullify }
  end

  create_table :votes do |t|
    t.references :votable, polymorphic: true
    t.references :user, foreign_key: { on_delete: :nullify }
  end

  create_table :roles do |t|
    t.string :name
    t.string :permissions, array: true
  end

  create_table :user_roles do |t|
    t.references :user, foreign_key: { on_delete: :cascade }
    t.references :role, foreign_key: { on_delete: :cascade }
  end
end
