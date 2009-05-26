class AmeeConnection
  def self.session
    @session ||= Amee::Session.create
  end
end