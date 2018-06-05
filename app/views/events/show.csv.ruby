CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv_column_names = ["区分","名前","会社","役職"]
  csv << csv_column_names
  @event.advisors.each do |advisor|
    csv_column_values = [
      '参加者',
      advisor.name,
      advisor.company_short_name,
      advisor.position
    ]
    csv << csv_column_values
  end
  @event.customers.each do |customer|
    csv_column_values = [
      '顧問先',
      customer.name,
      customer.company_short_name,
      customer.position
    ]
    csv << csv_column_values
  end
end
