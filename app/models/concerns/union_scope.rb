module UnionScope
  extend ActiveSupport::Concern

  module ClassMethods
   def union_scope(*scopes)
     id_column = "#{table_name}.id"
     sub_query = scopes.map { |s| s.select(id_column).to_sql }.join(" UNION ")
     where "#{id_column} IN (#{sub_query})"
   end
 end
end
