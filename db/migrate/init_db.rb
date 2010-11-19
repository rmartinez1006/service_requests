# ¡ ESTA MIGRACION BORRA LOS DATOS DE TODAS LAS TABLAS Y CARGA SOLO LOS DATOS INICIALES !
#
# To run this migration execute in rails console (rails c)
# $ require "db/migrate/init_db.rb"
# $ LoadInitData.up


require 'active_record/fixtures'

class InitDb < ActiveRecord::Migration
  def self.up
    down

    directory = File.join(File.dirname(__FILE__), "init_data")
    Fixtures.create_fixtures(directory, "administration_user_roles")
    Fixtures.create_fixtures(directory, "catalogs_comment_types")
    Fixtures.create_fixtures(directory, "catalogs_priorities")
    Fixtures.create_fixtures(directory, "catalogs_request_statuses")
    Fixtures.create_fixtures(directory, "catalogs_units")
    Fixtures.create_fixtures(directory, "catalogs_ubications")
    Fixtures.create_fixtures(directory, "administration_users")    
  end

  def self.down
    Administration::User.delete_all
    Catalogs::Supplier.delete_all
    Budgets::Budget.delete_all
    Catalogs::CommentType.delete_all
    RequestsAdministration::Commentary.delete_all
    Catalogs::Priority.delete_all
    RequestsAdministration::Delegation.delete_all
    RequestsAdministration::SupportRequest.delete_all
    Catalogs::Ubication.delete_all
    Catalogs::Unit.delete_all
    Catalogs::RequestStatus
    Administration::UserRole.delete_all
  end
  
end
