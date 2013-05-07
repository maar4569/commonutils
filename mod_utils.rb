require "fileutils"
module ExUtils
    def exDelete( srcPath )
        begin
            if FileTest::directory?( srcPath ) then
                Dir.foreach( srcPath ){ | tmpPath|
                    next if /^\.+$/ =~ tmpPath 
                    exDelete( "#{srcPath.sub(/\/+$/,"")}/#{tmpPath}" )
                }
                Dir.delete( srcPath )
            elsif FileTest::file?( srcPath ) then
                File.delete( srcPath )
            else
                p "This path is not a Directory or File. ( #{srcPath} )"
                return false
            end
        rescue
            p "exception happend. #{self.class.name}.#{__method__}"
            p "#{$!} #{$@}"
            return false
        end
        return true
    end
    def exMkdir( dirName )
        begin
            if !( Dir.exists?( dirName ) ) then
                Dir.mkdir( dirName )
                #p "make directory #{dirName}"
            end
        rescue
            p "exception happend. #{self.class.name}.#{__method__}"
            p "#{$!} #{$@}"
        end
    end
    def exCopy( srcPath ,destPath )
        begin
            rootDir = File.basename( "#{srcPath}/" )
            if (FileTest::directory?( srcPath )) && (Dir.exists?( srcPath )) then
                destPathRoot = "#{destPath}/#{rootDir}"
                exMkdir( destPathRoot )
                Dir.glob( srcPath + '/**/*' ).each do | path |
                    if (FileTest::directory?( path )) && (Dir.exists?( path )) then #make sub directory
                        destDir = "#{destPathRoot}#{path.gsub( /#{srcPath}/, '')}"
                        exMkdir( destDir )
                    else                             #copy file
                        destPath2 = "#{destPathRoot}#{path.gsub( /#{srcPath}/, '')}"
                        FileUtils.cp( path , destPath2 )
                    end
                end
            elsif FileTest::file?( srcPath ) then
                FileUtils.cp( srcPath , destPath )
            end
        rescue
            p "exception happend. #{self.class.name}.#{__method__}"
            p "#{$!} #{$@}"
        end
    end
end
