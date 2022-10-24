class RemoveBlazerTables < ActiveRecord::Migration[6.1]
  def up
    drop_table :blazer_queries
    drop_table :blazer_audits
    drop_table :blazer_dashboards
    drop_table :blazer_dashboard_queries
    drop_table :blazer_checks
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
