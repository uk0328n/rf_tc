CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv_column_names = ["氏名","フリガナ","会社","会社（略称）","役職","郵便番号","住所","電話番号","FAX番号","メールアドレス","担当者氏名","担当者郵便番号","担当者住所","担当者電話番号","担当者FAX番号","担当者メールアドレス"]
  csv << csv_column_names
  @advisors.each do |advisor|
    csv_column_values = [
      advisor.name,
      advisor.kana,
      advisor.company,
      advisor.company_short_name,
      advisor.position,
      advisor.postal_code,
      advisor.address,
      advisor.tel,
      advisor.fax,
      advisor.email,
      advisor.contact_person_name,
      advisor.contact_postal_code,
      advisor.contact_address,
      advisor.contact_tel,
      advisor.contact_fax,
      advisor.contact_email
    ]
    csv << csv_column_values
  end
end
