CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv_column_names = ["会社ID","会社名","会社名（カナ）","会社略称","会社略称（カナ）"]
  csv << csv_column_names
  @companies.each do |company|
    csv_column_values = [
      company.id,
      company.name,
      company.kana,
      company.short_name,
      company.short_name_kana
    ]
    csv << csv_column_values
  end
end
