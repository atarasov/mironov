class ParseJob <  Struct.new(:attach_id)
  def perform
    DbfFile.find(attach_id).parse_data
  end
end
