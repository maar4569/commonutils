require 'logger'
require 'singleton'
EXCEPTION_MESSAGE='exception happend.'
LVL_FATAL='FATAL'
LVL_ERROR='ERROR'
LVL_WARN='WARN'
LVL_INFO='INFO'
LVL_DEBUG='DEBUG'

class ExLogger < Logger
    include Singleton
    attr_accessor :level
    def setDeviceAndLevel( dev,level )
        super(STDOUT)
#        self.setLogLevel( level )
    end
    def setLevel( level )
        tmpLevel = ""
        if level =~ /FATAL|ERROR|WARN|INFO|DEBUG/ then
	        case level
	            when LVL_FATAL
	                 tmpLevel = self::FATAL
	            when LVL_ERROR
	                 tmpLevel = self::ERROR
	            when LVL_WARN
	                 tmpLevel = self::WARN
	            when LVL_INFO
                     tmpLevel = self::INFO
	            when LVL_DEBUG
                     tmpLevel = self::DEBUG
	            else
	                 p 'level is invalid.'
	        end
            self.level = tmpLevel
        else
            p 'level is invalid.'
            return false
        end
        return true
    end
    private :setLogLevel
end
