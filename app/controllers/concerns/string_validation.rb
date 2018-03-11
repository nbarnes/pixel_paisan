
module StringValidation

  def massage_name(raw_name)
    raw_name.tr(' ', '_').gsub(/[^\w\s]/, '')
  end

end
