class AddAhoyToPages < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :ahoy_visit_id, :bigint
    add_column :events, :ahoy_visit_id, :bigint
    add_column :galleries, :ahoy_visit_id, :bigint
    add_column :libraries, :ahoy_visit_id, :bigint
  end
end
