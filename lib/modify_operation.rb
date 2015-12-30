class ModifyOperation
  
  def initialize(record_type, fields = {}, record_name = nil, force = false, recordChangeTag = nil)
    @record_type = record_type
    @record_name = record_name
    @record_change_tag = recordChangeTag
    @fields = fields
    @operationType = force ? "forceUpdate" : "update"
  end
  
  def to_json(options = {})
    hash = {operationType: @operationType}
    record = {recordType: @record_type, recordName: @record_name, recordChangeTag: @record_change_tag}
    fields = {}
    @fields.each_pair do |k,v|
      fields[k] = {value: v}
    end
    record[:fields] = fields
    hash[:record] = record 
    hash.to_json
  end
  
end