class AmeeConnection
  def self.session
    @session ||= Amee::Session.create
  end
  
  def self.auto_oneway_uid
    @auto_onewway_uid ||= session.get_data_category("/data/transport/plane/generic").drill(:size => "one way", :type => "auto").data_item_uid
  end
  
  def self.auto_return_uid
    @auto_return_uid ||= session.get_data_category("/data/transpor
    t/plane/generic").drill(:size => "return", :type => "auto").data_item_uid
  end
end