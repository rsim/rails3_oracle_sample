# patches for Rails 3.0 beta1 that are required by oracle_enhanced adapter

# PATCH: downcase table names in aliased_table_name_for and references_eager_loaded_tables? methods
# (as Oracle quoted table names are in uppercase)
ActiveRecord::Associations::ClassMethods::JoinDependency::JoinAssociation.class_eval do
  protected

  def aliased_table_name_for(name, suffix = nil)
    # always downcase quoted table name as Oracle quoted table names are in uppercase
    if !parent.table_joins.blank? && parent.table_joins.to_s.downcase =~ %r{join(\s+\w+)?\s+#{active_record.connection.quote_table_name(name).downcase}\son}
      @join_dependency.table_aliases[name] += 1
    end

    unless @join_dependency.table_aliases[name].zero?
      # if the table name has been used, then use an alias
      name = active_record.connection.table_alias_for "#{pluralize(reflection.name)}_#{parent_table_name}#{suffix}"
      table_index = @join_dependency.table_aliases[name]
      @join_dependency.table_aliases[name] += 1
      name = name[0..active_record.connection.table_alias_length-3] + "_#{table_index+1}" if table_index > 0
    else
      @join_dependency.table_aliases[name] += 1
    end

    name
  end
end



# PATCH: fix conditions when DateTime#to_date and DateTime#xmlschema methods are defined
ActiveRecord::Relation.class_eval do
  private

  def references_eager_loaded_tables?
    # always convert table names to downcase as in Oracle quoted table names are in uppercase
    joined_tables = (tables_in_string(arel.joins(arel)) + [table.name, table.table_alias]).compact.map(&:downcase).uniq
    (tables_in_string(to_sql) - joined_tables).any?
  end

  def tables_in_string(string)
    return [] if string.blank?
    # always convert table names to downcase as in Oracle quoted table names are in uppercase
    string.scan(/([a-zA-Z_][\.\w]+).?\./).flatten.map(&:downcase).uniq
  end
end



# PATCH: fix conditions when DateTime#to_date and DateTime#xmlschema methods are defined
class DateTime
  # Converts self to a Ruby Date object; time portion is discarded
  def to_date
    ::Date.new(year, month, day)
  end unless instance_methods(false).include?(:to_date)
  
  # Converts datetime to an appropriate format for use in XML
  def xmlschema
    strftime("%Y-%m-%dT%H:%M:%S%Z")
  end unless instance_methods(false).include?(:xmlschema)
end
