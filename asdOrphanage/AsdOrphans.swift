import AppKit

class AsdOrphans {
    
    class func analyse(directory: String) -> [String] {
        var asdFiles = [String]()
        var asdOrphans = [String]()
        
        if let fileList = NSFileManager.defaultManager().subpathsAtPath(directory) {
            
            for file in fileList {
                if file.hasSuffix(".asd") { asdFiles.append(file) }
            }
            
            for asdFile in asdFiles {
                let asdParentFile = asdFile.substringToIndex(asdFile.endIndex.advancedBy(-4))
                let asdParentFilePath = directory.stringByAppendingPathComponent(asdParentFile)
                if NSFileManager.defaultManager().fileExistsAtPath(asdParentFilePath) == false { asdOrphans.append(asdFile) }
            }
        }
        
        return asdOrphans
    }
    
    class func showFile(file: String) {
        NSWorkspace.sharedWorkspace().selectFile(file, inFileViewerRootedAtPath: "")
    }
    
}