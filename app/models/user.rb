class User < ApplicationRecord
  class << self
    # Filter by first_name, last_name or email
    # Vulnerability to sql injection via ''='' condition which lead to exposing all data with passwords as well
    def filter_by_query(query: nil)
      return all if query.blank?

      where("first_name LIKE '#{query}' OR
             last_name LIKE '#{query}' OR
             email LIKE '#{query}'")

      # Parameters usage to prevent sql injection
      # where("first_name LIKE :query OR
      #        last_name LIKE :query OR
      #        email LIKE :query", query: "#{query.strip}")
    end

    # Delete users by first_name, last_name or email
    # Vulnerability to sql injection via ''='' condition which lead to data loss
    def delete_all_by_query(query: nil)
      return delete_all if query.blank?

      filter_by_query(query: query).delete_all
    end
  end
end
