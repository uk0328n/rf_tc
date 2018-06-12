class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.simple_import(path, col_sep)
    data_array = []
    CSV.foreach(path, encoding: Encoding::SJIS, headers: true, col_sep: col_sep) do |row|
      data_array << self.new(get_import_params(row))
    end
    import data_array # activerecord-importのメソッドです。
  end

  private

  def self.get_import_params(row)
    headers = row.headers & self.column_names # 存在するカラム名のみに限定する
    headers.each_with_object({}) do |col, hash|
      if col == 'editor_code'
        hash[col.to_sym] = Admin.current.id
      else
        hash[col.to_sym] = row.field(col)
      end
    end
  end
end
