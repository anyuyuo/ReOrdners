require './db/sql'

class Image
    attr_accessor :id
    attr_accessor :filename
    attr_accessor :mimetype
    attr_accessor :content
    # :path is not needed since it will be static

    def initialize
        self.filename = ''
        self.mimetype = ''
        self.content = ''
    end

    def getDocument

    end
    
    def setAsParent

    end

    def delete

    end
end
