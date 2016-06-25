import Cocoa

class AsdController: NSViewController {
    
    var orphans = [String]()

    @IBOutlet weak var directoryField: NSTextField!
    @IBOutlet weak var orphansTable: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orphansTable.doubleAction = "showOrphan:"
        orphansTable.target = self
    }

    @IBAction func analyse(sender: NSButton) {
        let selectDirectory = NSOpenPanel()
        var directory = ""
        
        selectDirectory.canChooseDirectories = true
        selectDirectory.canChooseFiles = false
        
        if selectDirectory.runModal() == NSFileHandlingPanelOKButton {
            let directoryURL = selectDirectory.URLs[0] 
            directory = directoryURL.path!
            directoryField.stringValue = directory
            orphans = AsdOrphans.analyse(directory)
        }
        
        orphansTable.reloadData()
    }
    
    func showOrphan(sender: NSTableView) {
        if orphansTable.clickedRow != -1 {
            var file = orphans[orphansTable.clickedRow]
            file = directoryField.stringValue.stringByAppendingPathComponent(file)
            AsdOrphans.showFile(file)
        }
    }
    
}

// MARK: NSTableViewDataSource
extension AsdController: NSTableViewDataSource {
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return orphans.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row rowIndex: Int) -> AnyObject? {
        return orphans[rowIndex]
    }
    
}

// MARK: NSTableViewDelegate
extension AsdController: NSTableViewDelegate {
}
