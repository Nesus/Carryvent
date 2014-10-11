# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141011004157) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "buses", force: true do |t|
    t.integer  "evento_id"
    t.integer  "route_id"
    t.integer  "price"
    t.integer  "seats"
    t.string   "from"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "time"
  end

  add_index "buses", ["evento_id"], name: "index_buses_on_evento_id"
  add_index "buses", ["route_id"], name: "index_buses_on_route_id"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.integer  "region_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["region_id"], name: "index_cities_on_region_id"

  create_table "comments", force: true do |t|
    t.integer  "commentable_id",   default: 0
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          default: 0, null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "eventos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publicador_id"
    t.string   "name"
    t.string   "subtitle"
    t.string   "address"
    t.string   "information"
    t.integer  "organization_id"
    t.integer  "category_id"
    t.integer  "city_id"
    t.integer  "region_id"
    t.string   "image"
    t.float    "latitude"
    t.float    "longitude"
    t.date     "date"
    t.time     "time"
  end

  add_index "eventos", ["publicador_id"], name: "index_eventos_on_publicador_id"

  create_table "gustos", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gustos", ["category_id"], name: "index_gustos_on_category_id"
  add_index "gustos", ["user_id"], name: "index_gustos_on_user_id"

  create_table "mailboxer_conversation_opt_outs", force: true do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id"
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type"

  create_table "mailboxer_conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type"
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type"
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type"

  create_table "mailboxer_receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type"

  create_table "oferta", force: true do |t|
    t.string   "nombre"
    t.string   "desc"
    t.integer  "porcentaje"
    t.boolean  "mod_cantidad"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "contact_person"
    t.string   "phone"
    t.string   "facebook"
    t.string   "twitter"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
  end

  create_table "pasajes", force: true do |t|
    t.string   "codigo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reserva_id"
    t.integer  "asiento"
  end

  create_table "publicacion_carpools", force: true do |t|
    t.integer  "user_evento_id"
    t.date     "fecha"
    t.text     "descripcion"
    t.time     "hora_desde"
    t.string   "desde"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "asientos_disp"
    t.string   "tipo_vehiculo"
    t.string   "celular"
    t.string   "job_id"
  end

  create_table "publicadors", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.datetime "last_checked"
  end

  add_index "publicadors", ["email"], name: "index_publicadors_on_email", unique: true
  add_index "publicadors", ["reset_password_token"], name: "index_publicadors_on_reset_password_token", unique: true
  add_index "publicadors", ["username"], name: "index_publicadors_on_username", unique: true

  create_table "rankings", force: true do |t|
    t.integer  "value"
    t.text     "comment"
    t.boolean  "assist"
    t.boolean  "driver"
    t.integer  "user_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rankings", ["user_id"], name: "index_rankings_on_user_id"

  create_table "red_socials", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "red_socials", ["user_id"], name: "index_red_socials_on_user_id"

  create_table "regions", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservas", force: true do |t|
    t.string   "code"
    t.integer  "amount"
    t.integer  "user_evento_id"
    t.integer  "state"
    t.datetime "ttl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "job_id"
    t.text     "point"
  end

  add_index "reservas", ["user_evento_id"], name: "index_reservas_on_user_evento_id"

  create_table "routes", force: true do |t|
    t.text     "points"
    t.integer  "city_id"
    t.integer  "region_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "routes", ["city_id"], name: "index_routes_on_city_id"
  add_index "routes", ["region_id"], name: "index_routes_on_region_id"

  create_table "transaccion_carpools", force: true do |t|
    t.integer  "user_id"
    t.integer  "publicacion_carpool_id"
    t.boolean  "aceptado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "asientos"
    t.string   "job_id"
  end

  add_index "transaccion_carpools", ["publicacion_carpool_id"], name: "index_transaccion_carpools_on_publicacion_carpool_id"
  add_index "transaccion_carpools", ["user_id"], name: "index_transaccion_carpools_on_user_id"

  create_table "user_eventos", force: true do |t|
    t.integer  "user_id"
    t.integer  "evento_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nombre"
    t.text     "direccion"
    t.string   "foto"
    t.integer  "city_id"
    t.integer  "region_id"
    t.float    "ranking"
    t.boolean  "facebook_password"
    t.datetime "last_checked"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
