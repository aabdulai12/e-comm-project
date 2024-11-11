require 'uri'
module URI
  def self.escape(*args)
    CGI.escape(*args)
  end
end
