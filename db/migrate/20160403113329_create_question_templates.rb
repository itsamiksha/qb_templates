class CreateQuestionTemplates < ActiveRecord::Migration
  def change
    create_table :question_templates do |t|

      t.timestamps null: false
    end
  end
end
