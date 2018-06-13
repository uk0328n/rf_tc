CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv_column_names = ["イベント名","開催日","顧問氏名","顧問会社","顧問役職"]
  csv << csv_column_names
  @events.each do |event|
    event.advisors.includes(:event_details).where('event_details.attendance_type = 1').each do |advisor|
      csv_column_values = [
        event.name.encode!(Encoding::CP932, {
            :invalid => :replace,
            :undef   => :replace,
            :replace => "〓"}),
        event.event_date,
        advisor.name.encode!(Encoding::CP932, {
            :invalid => :replace,
            :undef   => :replace,
            :replace => "〓"}),
        advisor.company_short_name.encode!(Encoding::CP932, {
            :invalid => :replace,
            :undef   => :replace,
            :replace => "〓"}),
        advisor.position.encode!(Encoding::CP932, {
            :invalid => :replace,
            :undef   => :replace,
            :replace => "〓"})
      ]
      csv << csv_column_values
    end
  end
end
