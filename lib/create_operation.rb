class CreateOperation
  
  def initialize(record_type, fields)
    @record_type = record_type
    @fields = fields
  end
  
  def to_json(options = {})
    hash = {operationType: "create"}
    record = {recordType: @record_type}
    fields = {}
    @fields.each_pair do |k,v|
      fields[k] = {value: v}
    end
    record[:fields] = fields
    hash[:record] = record 
    hash.to_json
  end
  
end