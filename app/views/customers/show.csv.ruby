CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv_column_names = ["イベント名","開催日","顧問氏名","顧問会社","顧問役職"]
  csv << csv_column_names
  @events.each do |event|
    event.advisors.each do |advisor|
      csv_column_values = [
        event.name,
        event.event_date,
        advisor.name,
        advisor.company_short_name,
        advisor.position
      ]
      csv << csv_column_values
    end
  end
end
