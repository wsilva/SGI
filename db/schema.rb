# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110531214937) do

  create_table "ideias", :force => true do |t|
    t.integer  "usuario_id",                     :null => false
    t.string   "titulo",                         :null => false
    t.text     "texto",                          :null => false
    t.integer  "status",          :default => 0, :null => false
    t.string   "motivo_rejeicao"
    t.integer  "visitas"
    t.integer  "positivos"
    t.integer  "negativos"
    t.date     "dtpublicacao"
    t.date     "dtrejeicao"
    t.date     "dtpromocao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ideias", ["usuario_id"], :name => "index_ideias_on_usuario_id"

  create_table "sugestoes", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "ideia_id"
    t.text     "msg",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sugestoes", ["usuario_id", "ideia_id"], :name => "index_sugestoes_on_usuario_id_and_ideia_id"

  create_table "usuarios", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "nome"
    t.date     "dtnascimento"
    t.string   "url"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

end
