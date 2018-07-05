CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv_column_names = ["顧客ランク","氏名","フリガナ","会社","会社（略称）","会社（カナ）","役職","郵便番号","住所","電話番号","FAX番号","メールアドレス","担当者氏名","担当者郵便番号","担当者住所","担当者電話番号","担当者FAX番号","担当者メールアドレス"]
  csv << csv_column_names
  @customers.each do |customer|
    csv_column_values = [
      customer.rank,
      customer.name,
      customer.kana,
      customer.company,
      customer.company_short_name,
      customer.company_kana,
      customer.position,
      customer.postal_code,
      customer.address,
      customer.tel,
      customer.fax,
      customer.email,
      customer.contact_person_name,
      customer.contact_postal_code,
      customer.contact_address,
      customer.contact_tel,
      customer.contact_fax,
      customer.contact_email
    ]
    csv << csv_column_values
  end
end
