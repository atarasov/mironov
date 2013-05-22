class ParseCashJob <  Struct.new(:attach_id)
  def perform
    CashFiles.find(attach_id).parse_data
  end
end