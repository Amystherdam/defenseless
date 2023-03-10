class CreateVulnerabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :vulnerabilities do |t|
      t.string :name
      t.string :description
      t.integer :impact
      t.string :solution
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
