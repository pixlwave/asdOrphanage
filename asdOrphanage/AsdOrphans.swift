import AppKit

class AsdOrphans {
    
    class func analyse(_ directory: String) -> [String] {
        var asdFiles = [String]()
        var asdOrphans = [String]()
        
        if let fileList = FileManager.default.subpaths(atPath: directory) {
            
            for file in fileList {
                if file.hasSuffix(".asd") { asdFiles.append(file) }
            }
            
            for asdFile in asdFiles {
                let asdParentFile = String(asdFile[..<asdFile.index(asdFile.endIndex, offsetBy: -4)])
                let asdParentFilePath = URL(fileURLWithPath: asdParentFile, relativeTo: URL(fileURLWithPath: directory)).path
                if FileManager.default.fileExists(atPath: asdParentFilePath) == false {
                    asdOrphans.append(asdFile)
                }
            }
        }
        
        return asdOrphans
    }
    
    class func showFile(_ url: URL) {
        NSWorkspace.shared.selectFile(url.path, inFileViewerRootedAtPath: "")
    }
    
}
