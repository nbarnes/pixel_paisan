
module StringValidation

  def massage_name(raw_name)
    raw_name.gsub(/\ /, '_').gsub(/[^\w\s]/, '')
  end

end
