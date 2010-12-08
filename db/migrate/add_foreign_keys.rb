# To run this migration execute in rails console (rails c)
# $ require "db/migrate/add_foreign_keys.rb"
# $ AddForeignKeys.up / AddForeignKeys.down

class AddForeignKeys < ActiveRecord::Migration
   def self.up
      # administration_user_hierachies
      execute "alter table administration_user_hierachies
               add constraint fk_user_hierachies_users
               foreign key (user_id) references administration_users(id)"

      execute "alter table administration_user_hierachies
               add constraint fk_user_hierachies_helpers
               foreign key (helper_id) references administration_users(id)"

      # administration_users
      execute "alter table administration_users
               add constraint fk_users_roles
               foreign key (role_id) references administration_user_roles(id)"

      execute "alter table administration_users
               add constraint fk_users_ubications
               foreign key (ubication_id) references catalogs_ubications(id)"

      # budgets_budget_supplies
      execute "alter table budgets_budget_supplies
               add constraint fk_budget_supplies_budgets
               foreign key (budget_id) references budgets_budgets(id)
               on update cascade
               on delete cascade"

      # budgets_budgets
      execute "alter table budgets_budgets
               add constraint fk_budgets_support_requests
               foreign key (support_request_id) references request_support_requests(id)"

      execute "alter table budgets_budgets
               add constraint fk_budgets_support_suppliers
               foreign key (supplier_id) references catalogs_suppliers(id)"

      execute "alter table budgets_budgets
               add constraint fk_budgets_support_users
               foreign key (user_id) references administration_users(id)"

      # catalogs_ubications
      execute "alter table catalogs_ubications
               add constraint fk_ubications_units
               foreign key (unit_id) references catalogs_units(id)"      

      # request_commentaries
      execute "alter table request_commentaries
               add constraint fk_commentaries_support_requests
               foreign key (support_request_id) references request_support_requests(id)"

      execute "alter table request_commentaries
               add constraint fk_commentaries_support_users
               foreign key (user_id) references administration_users(id)"

      execute "alter table request_commentaries
               add constraint fk_commentaries_support_comment_types
               foreign key (comment_type_id) references catalogs_comment_types(id)"

      #request_delegations
      execute "alter table request_delegations
               add constraint fk_delegations_support_requests
               foreign key (support_request_id) references request_support_requests(id)"

      execute "alter table request_delegations
               add constraint fk_delegations_users
               foreign key (user_id) references administration_users(id)"

      execute "alter table request_delegations
               add constraint fk_delegations_helpers
               foreign key (helper_id) references administration_users(id)"

      execute "alter table request_delegations
               add constraint fk_delegations_priorities
               foreign key (priority_id) references catalogs_priorities(id)"

      # request_support_requests
      execute "alter table request_support_requests
               add constraint fk_support_requests_ubications
               foreign key (ubication_id) references catalogs_ubications(id)"

      execute "alter table request_support_requests
               add constraint fk_support_requests_helpers
               foreign key (helper_id) references administration_users(id)"

      execute "alter table request_support_requests
               add constraint fk_support_requests_suppor_types
               foreign key (support_type_id) references catalogs_support_types(id)"

      execute "alter table request_support_requests
               add constraint fk_support_requests_statuses
               foreign key (request_status_id) references catalogs_request_statuses(id)"
   end

   def self.down      
      # administration_user_hierachies
      execute "alter table administration_user_hierachies
               drop constraint fk_user_hierachies_users"

      execute "alter table administration_user_hierachies
               drop constraint fk_user_hierachies_helpers"

      # administration_users
      execute "alter table administration_users
               drop constraint fk_users_roles"
      
      execute "alter table administration_users
               drop constraint fk_users_ubications"

      # budgets_budget_supplies
      execute "alter table budgets_budget_supplies
               drop constraint fk_budget_supplies_budgets"

      # budgets_budgets
      execute "alter table budgets_budgets
               drop constraint fk_budgets_support_requests"

      execute "alter table budgets_budgets
               drop constraint fk_budgets_support_suppliers"

      execute "alter table budgets_budgets
               drop constraint fk_budgets_support_users"

      # catalogs_ubications
      execute "alter table catalogs_ubications
               drop constraint fk_ubications_units"

      # request_commentaries
      execute "alter table request_commentaries
               drop constraint fk_commentaries_support_requests"

      execute "alter table request_commentaries
               drop constraint fk_commentaries_support_users"

      execute "alter table request_commentaries
               drop constraint fk_commentaries_support_comment_types"

      #request_delegations
      execute "alter table request_delegations
               drop constraint fk_delegations_support_requests"

      execute "alter table request_delegations
               drop constraint fk_delegations_users"

      execute "alter table request_delegations
               drop constraint fk_delegations_helpers"

      execute "alter table request_delegations
               drop constraint fk_delegations_priorities"

      # request_support_requests
      execute "alter table request_support_requests
               drop constraint fk_support_requests_ubications"

      execute "alter table request_support_requests
               drop constraint fk_support_requests_helpers"

      execute "alter table request_support_requests
             drop constraint fk_support_requests_suppor_types"

      execute "alter table request_support_requests
               drop constraint fk_support_requests_statuses"
             
   end
end