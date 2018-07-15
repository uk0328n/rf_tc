CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv_column_names = ["イベント名","開催日","参加者氏名","参加者会社","参加者役職"]
  csv << csv_column_names
  @events.each do |event|
    event.people.includes(:activities).where('activities.fixed_role_type = 2').where.not('activities.person_id = ?', @customer.id).where('activities.attendance_type = 1').each do |advisor|
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
        if advisor.company.blank?
          ""
        else
          advisor.company&.short_name.encode!(Encoding::CP932, {
              :invalid => :replace,
              :undef   => :replace,
              :replace => "〓"})
        end,
        advisor.position.encode!(Encoding::CP932, {
            :invalid => :replace,
            :undef   => :replace,
            :replace => "〓"})
      ]
      csv << csv_column_values
    end
  end
end
