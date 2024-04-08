class DropPostForms < ActiveRecord::Migration[6.0]
  def up
    drop_table :post_forms
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end