class NormalizeDataStub < NormalizeData

  def call
    @@_call_called_count ||= 0
    @@_call_called_count += 1
    self
  end

  def self._call_called_count
    @@_call_called_count ||= 0
  end

end