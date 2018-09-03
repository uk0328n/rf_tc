CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv_column_names = ["区分","顧客レベル","名前","会社","役職"]
  csv << csv_column_names
  if @event.is_fixed
    @event.people.includes(:activities).where('activities.attendance_type = 1').where('activities.fixed_role_type = 1').each do |customer|
      csv_column_values = [
        '顧問先',
        customer.rank,
        customer.name,
        customer.company&.short_name,
        customer.position
      ]
      csv << csv_column_values
    end
    @event.people.includes(:activities).where('activities.attendance_type = 1').where('activities.fixed_role_type = 2').each do |advisor|
      csv_column_values = [
        '参加者',
        advisor.rank,
        advisor.name,
        advisor.company&.short_name,
        advisor.position
      ]
      csv << csv_column_values
    end
  else
    @event.people.includes(:activities).where('activities.attendance_type = 1').where('people.role_type = 1').each do |customer|
      csv_column_values = [
        '顧問先',
        customer.rank,
        customer.name,
        customer.company&.short_name,
        customer.position
      ]
      csv << csv_column_values
    end
    @event.people.includes(:activities).where('activities.attendance_type = 1').where('people.role_type = 2').each do |advisor|
      csv_column_values = [
        '参加者',
        advisor.rank,
        advisor.name,
        advisor.company&.short_name,
        advisor.position
      ]
      csv << csv_column_values
    end
  end
end
