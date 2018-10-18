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
## Baseform
## Copyright (C) 2018  Baseform

## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.



ActiveRecord::Schema.define(version: 20180718163642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "base_dados", id: :integer, force: :cascade do |t|
    t.datetime "data",                       null: false
    t.datetime "data_abertura"
    t.datetime "data_fim"
    t.string   "designacao",    limit: 255,  null: false
    t.string   "observacoes",   limit: 2000
  end

  create_table "city", id: :integer, force: :cascade do |t|
    t.string "fkdeployment", limit: 255
    t.float  "lat",                      null: false
    t.float  "lon",                      null: false
    t.text   "metadata"
    t.string "name",         limit: 255, null: false
    t.string "country",      limit: 255, null: false
    t.string "image_name",   limit: 255
    t.string "image_mime",   limit: 255
    t.index ["fkdeployment"], name: "city_dep", using: :btree
  end

  create_table "comentario_ficheiro", id: :integer, force: :cascade do |t|
    t.integer "fkcomentario",             null: false
    t.string  "mime",         limit: 255
    t.string  "nomeficheiro", limit: 255
    t.integer "size"
    t.index ["fkcomentario"], name: "idx_comentario_file_comentario", using: :btree
  end

  create_table "documento", id: :integer, force: :cascade do |t|
    t.datetime "data",                       null: false
    t.datetime "data_documento"
    t.string   "designacao",     limit: 200, null: false
    t.string   "file_type",      limit: 20
    t.integer  "fkprocesso"
    t.integer  "fksite_tab"
    t.boolean  "imagem"
    t.string   "link",           limit: 500
    t.string   "mime",           limit: 255
    t.string   "nomeficheiro",   limit: 255
    t.integer  "size"
    t.integer  "tipo"
    t.index ["fkprocesso", "fksite_tab"], name: "idx_doc_fksitetab_proc", using: :btree
  end

  create_table "evento", id: :integer, force: :cascade do |t|
    t.datetime "data",                     null: false
    t.datetime "data_registo"
    t.string   "designacao",   limit: 200, null: false
    t.integer  "fkprocesso",               null: false
    t.string   "link",         limit: 500
    t.string   "local",        limit: 255, null: false
    t.index ["fkprocesso"], name: "idx_evento_proc", using: :btree
  end

  create_table "evento_ficheiro", id: :integer, force: :cascade do |t|
    t.datetime "data"
    t.datetime "data_documento"
    t.string   "designacao",     limit: 200, null: false
    t.integer  "fkevento",                   null: false
    t.string   "mime",           limit: 255
    t.string   "nomeficheiro",   limit: 255
    t.integer  "size"
    t.index ["fkevento"], name: "idx_evento_file_evento", using: :btree
  end

  create_table "formulario", id: :integer, force: :cascade do |t|
    t.datetime "data_abertura"
    t.datetime "data_fim"
    t.integer  "fk_base_dados",                  null: false
    t.integer  "fkprocesso"
    t.text     "info_introdutoria"
    t.string   "item_mostrar_lista", limit: 50
    t.string   "nome",               limit: 200, null: false
    t.string   "observacoes",        limit: 500
    t.boolean  "repetivel",                      null: false
    t.text     "script"
    t.index ["fk_base_dados", "fkprocesso"], name: "idx_form_bd_proc", using: :btree
  end

  create_table "gamification_log", id: :integer, force: :cascade do |t|
    t.string   "action",        limit: 50,  null: false
    t.string   "action_target", limit: 100
    t.datetime "timestamp",                 null: false
    t.string   "username",      limit: 50,  null: false
    t.string   "issue_code",    limit: 70,  null: false
    t.string   "issue_locale",  limit: 10,  null: false
    t.string   "system_id",     limit: 255, null: false
  end

  create_table "got_it_section", id: :integer, force: :cascade do |t|
    t.integer "fk_participante", null: false
    t.integer "fk_seccao",       null: false
    t.index ["fk_participante", "fk_seccao"], name: "un_idx_got_it_section_part", unique: true, using: :btree
  end

  create_table "item", id: :integer, force: :cascade do |t|
    t.string  "codigo",            limit: 50,  null: false
    t.boolean "editable",                      null: false
    t.boolean "end_inline",                    null: false
    t.integer "fk_formulario",                 null: false
    t.integer "fk_tipo",                       null: false
    t.text    "info"
    t.boolean "inline",                        null: false
    t.boolean "is_obrigatorio",                null: false
    t.string  "nome",              limit: 500
    t.text    "opcoes"
    t.string  "style_class",       limit: 200
    t.string  "style_class_label", limit: 200
    t.index ["fk_formulario", "fk_tipo"], name: "idx_item_form_tipo", using: :btree
  end

  create_table "item_resposta", id: :integer, force: :cascade do |t|
    t.integer "fk_item",     null: false
    t.integer "fk_resposta", null: false
    t.text    "valor",       null: false
    t.index ["fk_item", "fk_resposta"], name: "un_idx_itemresp_item_resp", unique: true, using: :btree
  end

  create_table "item_resposta_ficheiro", id: :integer, force: :cascade do |t|
    t.integer "fk_item_resposta",             null: false
    t.string  "mime",             limit: 255
    t.string  "name",             limit: 255
    t.integer "size"
    t.index ["fk_item_resposta"], name: "idx_item_resp_file", using: :btree
  end

  create_table "mapa", primary_key: "pkid", id: :integer, force: :cascade do |t|
    t.integer "fkprocesso",             null: false
    t.text    "json"
    t.string  "nome",       limit: 500, null: false
    t.index ["fkprocesso"], name: "idx_mapa_proc", using: :btree
  end

  create_table "messages", id: :integer, force: :cascade do |t|
    t.string   "about",          limit: 500, null: false
    t.datetime "date"
    t.integer  "fkparticipante"
    t.integer  "status"
    t.text     "body"
    t.string   "sistema",        limit: 50,  null: false
    t.index ["fkparticipante"], name: "idx_participante", using: :btree
  end

  create_table "participante", primary_key: "pkid", id: :integer, force: :cascade do |t|
    t.boolean  "activo"
    t.string   "age_bracket",     limit: 50
    t.string   "check_key",       limit: 50
    t.datetime "data_registo"
    t.string   "email",           limit: 100,  null: false
    t.string   "education_level", limit: 50
    t.string   "number_children", limit: 50
    t.text     "gamification"
    t.string   "gender",          limit: 50
    t.string   "md5pwd",          limit: 255
    t.string   "nome",            limit: 255,  null: false
    t.string   "profession",      limit: 50
    t.text     "metadata"
    t.string   "provider",        limit: 50
    t.string   "token",           limit: 3000
    t.string   "uid",             limit: 50
    t.index ["email", "md5pwd"], name: "idx_part_email_pass", using: :btree
    t.index ["email"], name: "un_idx_part_email", unique: true, using: :btree
  end

  create_table "participante_imagem", id: :integer, force: :cascade do |t|
    t.integer "fkparticipante",             null: false
    t.string  "mime",           limit: 255
    t.string  "nomeficheiro",   limit: 255
    t.integer "size"
    t.index ["fkparticipante"], name: "idx_participante_imagem", using: :btree
  end

  create_table "partilhas", id: :integer, force: :cascade do |t|
    t.datetime "data"
    t.string   "rede",  limit: 255, null: false
    t.integer  "valor"
    t.index ["rede"], name: "idx_partilhas_rede", using: :btree
  end

  create_table "processo", primary_key: "pkid", id: :integer, force: :cascade do |t|
    t.string   "codigo",                    limit: 70,  null: false
    t.datetime "data_fim",                              null: false
    t.datetime "data_inicio",                           null: false
    t.string   "descricao",                 limit: 500, null: false
    t.integer  "fktecnico"
    t.integer  "fkthumbnail"
    t.string   "locale",                    limit: 10,  null: false
    t.text     "gamification"
    t.boolean  "publicado"
    t.string   "shape_url",                 limit: 500
    t.string   "sistema",                   limit: 255, null: false
    t.string   "titulo",                    limit: 200, null: false
    t.integer  "fkscope"
    t.string   "hashtags",                  limit: 255
    t.string   "shape_mobile_url",          limit: 500
    t.integer  "fk_city"
    t.boolean  "mapontop"
    t.string   "type",                      limit: 9,   null: false
    t.string   "comments_title"
    t.text     "comments_description"
    t.text     "gamification_chart_iframe"
    t.index ["fktecnico", "fkscope", "sistema"], name: "idx_proc_fktecnico_fkscope_sistema", using: :btree
  end

  create_table "processo_tags", id: :integer, force: :cascade do |t|
    t.integer "processo_fk"
    t.integer "tag_fk"
  end

  create_table "r_like_comentario", id: :integer, force: :cascade do |t|
    t.integer "fkparticipante", null: false
    t.integer "fkcomentario",   null: false
    t.integer "score",          null: false
    t.index ["fkparticipante", "fkcomentario"], name: "idx_like_comment", using: :btree
  end

  create_table "r_mapa_shapefile", primary_key: "pkid", id: :integer, force: :cascade do |t|
    t.integer "fk_mapa",      null: false
    t.integer "fk_shapefile", null: false
    t.integer "order_number", null: false
    t.index ["fk_mapa", "fk_shapefile"], name: "idx_mapashape_proc", using: :btree
  end

  create_table "r_participante_codigo", id: :integer, force: :cascade do |t|
    t.string   "code",           limit: 70, null: false
    t.datetime "data"
    t.integer  "fkparticipante",            null: false
    t.string   "originlocale",   limit: 10, null: false
  end

  create_table "r_participante_comentario", id: :integer, force: :cascade do |t|
    t.string   "comentario",     limit: 1500
    t.datetime "data"
    t.integer  "fkparticipante",                          null: false
    t.integer  "fkprocesso",                              null: false
    t.boolean  "publico"
    t.string   "tipo",           limit: 50,               null: false
    t.integer  "status",                      default: 0, null: false
    t.integer  "likes",                       default: 0, null: false
    t.integer  "dislikes",                    default: 0, null: false
    t.integer  "fkresponseto"
    t.string   "title",          limit: 200
    t.index ["fkparticipante", "fkprocesso"], name: "idx_part_comment", using: :btree
  end

  create_table "r_participante_evento", id: :integer, force: :cascade do |t|
    t.datetime "data"
    t.integer  "fkevento",       null: false
    t.integer  "fkparticipante", null: false
    t.index ["fkparticipante", "fkevento"], name: "un_idx_part_event", unique: true, using: :btree
  end

  create_table "r_participante_not_tipologia", id: :integer, force: :cascade do |t|
    t.integer "fkparticipante", null: false
    t.integer "fkscope",        null: false
    t.index ["fkparticipante", "fkscope"], name: "un_idx_part_not_scope", unique: true, using: :btree
  end

  create_table "r_participante_processo", id: :integer, force: :cascade do |t|
    t.datetime "data"
    t.integer  "fkparticipante", null: false
    t.integer  "fkprocesso",     null: false
    t.boolean  "is_following",   null: false
    t.index ["fkparticipante", "fkprocesso"], name: "un_idx_part_proc", unique: true, using: :btree
  end

  create_table "r_participante_sistema", id: :integer, force: :cascade do |t|
    t.datetime "data_login",                null: false
    t.integer  "fkparticipante",            null: false
    t.string   "fksistema",      limit: 10, null: false
    t.index ["fkparticipante", "fksistema"], name: "idx_participante_sistema", using: :btree
  end

  create_table "resposta", id: :integer, force: :cascade do |t|
    t.integer  "codigo"
    t.datetime "data_abertura"
    t.datetime "data_submissao"
    t.datetime "data_ultima_alteracao"
    t.integer  "fk_formulario",         null: false
    t.integer  "fkparticipante",        null: false
    t.index ["fk_formulario", "fkparticipante"], name: "un_idx_resp_form_part", unique: true, using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scope", id: :integer, force: :cascade do |t|
    t.string "code",         limit: 50,  null: false
    t.text   "localization",             null: false
    t.string "system",       limit: 255, null: false
    t.text   "description"
    t.index ["code", "system"], name: "idx_scope_code_syst", using: :btree
  end

  create_table "scope_tag", id: :integer, force: :cascade do |t|
    t.integer "scope_id", null: false
    t.integer "tag_id",   null: false
  end

  create_table "seccao", id: :integer, force: :cascade do |t|
    t.text    "corpo"
    t.integer "fkprocesso",            null: false
    t.integer "indice",                null: false
    t.string  "titulo",     limit: 50, null: false
    t.index ["fkprocesso"], name: "idx_seccao_proc", using: :btree
  end

  create_table "shapefile", primary_key: "pkid", id: :integer, force: :cascade do |t|
    t.string "nome", limit: 500, null: false
  end

  create_table "site_props", id: :integer, force: :cascade do |t|
    t.string "sistema",    limit: 50, null: false
    t.text   "properties",            null: false
  end

  create_table "site_tab", id: :integer, force: :cascade do |t|
    t.text    "body"
    t.string  "code",    limit: 20, null: false
    t.string  "locale",  limit: 10, null: false
    t.boolean "online",             null: false
    t.string  "sistema", limit: 50, null: false
    t.string  "title",   limit: 20, null: false
    t.index ["sistema"], name: "idx_sitetab_sistema", using: :btree
  end

  create_table "systems", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "t_tipo_item", id: :integer, force: :cascade do |t|
    t.string "nome", limit: 100
  end

  create_table "tag", id: :integer, default: -> { "nextval('pk_tag_seq'::regclass)" }, force: :cascade do |t|
    t.string "tag", limit: 200
  end

  create_table "thumbnail", id: :integer, force: :cascade do |t|
    t.string "nome", limit: 255, null: false
    t.string "mime", limit: 255, null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id", using: :btree
    t.index ["user_id"], name: "index_user_roles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.boolean  "online",                 default: false
    t.datetime "last_action"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "comentario_ficheiro", "r_participante_comentario", column: "fkcomentario", name: "comentario_ficheiro_fkcomentario_fkey"
  add_foreign_key "documento", "processo", column: "fkprocesso", primary_key: "pkid", name: "documento_fkprocesso_fkey"
  add_foreign_key "documento", "site_tab", column: "fksite_tab", name: "documento_fksite_tab_fkey"
  add_foreign_key "evento", "processo", column: "fkprocesso", primary_key: "pkid", name: "evento_fkprocesso_fkey"
  add_foreign_key "evento_ficheiro", "evento", column: "fkevento", name: "evento_ficheiro_fkevento_fkey"
  add_foreign_key "formulario", "base_dados", column: "fk_base_dados", name: "formulario_fk_base_dados_fkey"
  add_foreign_key "formulario", "processo", column: "fkprocesso", primary_key: "pkid", name: "formulario_fkprocesso_fkey"
  add_foreign_key "got_it_section", "participante", column: "fk_participante", primary_key: "pkid", name: "got_it_section_fk_participante_fkey"
  add_foreign_key "got_it_section", "participante", column: "fk_participante", primary_key: "pkid", name: "got_it_section_fk_participante_fkey1"
  add_foreign_key "got_it_section", "seccao", column: "fk_seccao", name: "got_it_section_fk_seccao_fkey"
  add_foreign_key "got_it_section", "seccao", column: "fk_seccao", name: "got_it_section_fk_seccao_fkey1"
  add_foreign_key "item", "formulario", column: "fk_formulario", name: "item_fk_formulario_fkey"
  add_foreign_key "item", "t_tipo_item", column: "fk_tipo", name: "item_fk_tipo_fkey"
  add_foreign_key "item_resposta", "item", column: "fk_item", name: "item_resposta_fk_item_fkey"
  add_foreign_key "item_resposta", "resposta", column: "fk_resposta", name: "item_resposta_fk_resposta_fkey"
  add_foreign_key "item_resposta_ficheiro", "item_resposta", column: "fk_item_resposta", name: "item_resposta_ficheiro_fk_item_resposta_fkey"
  add_foreign_key "mapa", "processo", column: "fkprocesso", primary_key: "pkid", name: "mapa_fkprocesso_fkey"
  add_foreign_key "messages", "participante", column: "fkparticipante", primary_key: "pkid", name: "messages_fkparticipante_fkey"
  add_foreign_key "participante_imagem", "participante", column: "fkparticipante", primary_key: "pkid", name: "participante_imagem_fkparticipante_fkey"
  add_foreign_key "processo", "city", column: "fk_city", name: "processo_fk_city_fkey"
  add_foreign_key "processo", "public._user", column: "fktecnico", name: "processo_fktecnico_fkey"
  add_foreign_key "processo", "scope", column: "fkscope", name: "processo_fkscope_fkey"
  add_foreign_key "processo", "thumbnail", column: "fkthumbnail", name: "processo_fkthumbnail_fkey"
  add_foreign_key "processo_tags", "processo", column: "processo_fk", primary_key: "pkid", name: "processo_tags_processo_fk_fkey"
  add_foreign_key "processo_tags", "processo", column: "processo_fk", primary_key: "pkid", name: "processo_tags_processo_fk_fkey1"
  add_foreign_key "processo_tags", "tag", column: "tag_fk", name: "processo_tags_tag_fk_fkey"
  add_foreign_key "processo_tags", "tag", column: "tag_fk", name: "processo_tags_tag_fk_fkey1"
  add_foreign_key "r_like_comentario", "participante", column: "fkparticipante", primary_key: "pkid", name: "r_like_comentario_fkparticipante_fkey"
  add_foreign_key "r_like_comentario", "r_participante_comentario", column: "fkcomentario", name: "r_like_comentario_fkcomentario_fkey"
  add_foreign_key "r_mapa_shapefile", "mapa", column: "fk_mapa", primary_key: "pkid", name: "r_mapa_shapefile_fk_mapa_fkey"
  add_foreign_key "r_mapa_shapefile", "shapefile", column: "fk_shapefile", primary_key: "pkid", name: "r_mapa_shapefile_fk_shapefile_fkey"
  add_foreign_key "r_participante_codigo", "participante", column: "fkparticipante", primary_key: "pkid", name: "r_participante_codigo_fkparticipante_fkey"
  add_foreign_key "r_participante_comentario", "participante", column: "fkparticipante", primary_key: "pkid", name: "r_participante_comentario_fkparticipante_fkey"
  add_foreign_key "r_participante_comentario", "processo", column: "fkprocesso", primary_key: "pkid", name: "r_participante_comentario_fkprocesso_fkey"
  add_foreign_key "r_participante_comentario", "r_participante_comentario", column: "fkresponseto", name: "r_participante_comentario_fkresponseto_fkey"
  add_foreign_key "r_participante_evento", "evento", column: "fkevento", name: "r_participante_evento_fkevento_fkey"
  add_foreign_key "r_participante_evento", "participante", column: "fkparticipante", primary_key: "pkid", name: "r_participante_evento_fkparticipante_fkey"
  add_foreign_key "r_participante_not_tipologia", "participante", column: "fkparticipante", primary_key: "pkid", name: "r_participante_not_tipologia_fkparticipante_fkey"
  add_foreign_key "r_participante_not_tipologia", "scope", column: "fkscope", name: "r_participante_not_tipologia_fkscope_fkey"
  add_foreign_key "r_participante_processo", "participante", column: "fkparticipante", primary_key: "pkid", name: "r_participante_processo_fkparticipante_fkey"
  add_foreign_key "r_participante_processo", "processo", column: "fkprocesso", primary_key: "pkid", name: "r_participante_processo_fkprocesso_fkey"
  add_foreign_key "r_participante_sistema", "participante", column: "fkparticipante", primary_key: "pkid", name: "r_participante_sistema_fkparticipante_fkey"
  add_foreign_key "resposta", "formulario", column: "fk_formulario", name: "resposta_fk_formulario_fkey"
  add_foreign_key "resposta", "participante", column: "fkparticipante", primary_key: "pkid", name: "resposta_fkparticipante_fkey"
  add_foreign_key "scope_tag", "scope", name: "scope_tag_scope_id_fkey"
  add_foreign_key "scope_tag", "tag", name: "scope_tag_tag_id_fkey"
  add_foreign_key "scope_tag", "tag", name: "scope_tag_tag_id_fkey1"
  add_foreign_key "seccao", "processo", column: "fkprocesso", primary_key: "pkid", name: "seccao_fkprocesso_fkey"
end
