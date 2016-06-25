import Cocoa

class AsdController: NSViewController {
    
    var orphans = [String]()

    @IBOutlet weak var directoryField: NSTextField!
    @IBOutlet weak var orphansTable: NSTableView!

    @IBAction func analyse(_ sender: NSButton) {
        let selectDirectory = NSOpenPanel()
        var directory = ""
        
        selectDirectory.canChooseDirectories = true
        selectDirectory.canChooseFiles = false
        
        if selectDirectory.runModal() == .OK {
            let directoryURL = selectDirectory.urls[0] 
            directory = directoryURL.path
            directoryField.stringValue = directory
            orphans = AsdOrphans.analyse(directory)
        }
        
        orphansTable.reloadData()
    }
    
    @IBAction func showOrphan(_ sender: NSTableView) {
        if orphansTable.clickedRow != -1 {
            let file = orphans[orphansTable.clickedRow]
            let url = URL(fileURLWithPath: file, relativeTo: URL(fileURLWithPath: directoryField.stringValue))
            AsdOrphans.showFile(url)
        }
    }
    
}

// MARK: NSTableViewDataSource
extension AsdController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return orphans.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return orphans[row]
    }
    
}

// MARK: NSTableViewDelegate
extension AsdController: NSTableViewDelegate {
}
