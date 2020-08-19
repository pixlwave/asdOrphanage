import SwiftUI

struct AsdView: View {
    @State private var directory: String?
    @State private var orphans = [String]()
    @State private var selected: String?
    
    var body: some View {
        VStack {
            HStack {
                Button("Analyse") { analyse() }
                Text(directory ?? "Click Analyse and choose directory to begin").lineLimit(1)
                Spacer()
            }
            List(orphans, id: \.self, selection: $selected) { orphan in
                HStack {
                    Text(orphan)
                    Spacer()
                }
                .contentShape(Rectangle())
                .gesture(TapGesture().onEnded { _ in
                    selected = orphan
                })
                .simultaneousGesture(TapGesture(count: 2).onEnded { _ in
                    show(orphan)
                })
            }
            .border(Color(.separatorColor), width: 1)
        }
        .padding()
    }
    
    func analyse() {
        let selectDirectory = NSOpenPanel()
        var directory = ""
        
        selectDirectory.canChooseDirectories = true
        selectDirectory.canChooseFiles = false
        
        if selectDirectory.runModal() == .OK {
            let directoryURL = selectDirectory.urls[0]
            directory = directoryURL.path
            self.directory = directory
            orphans = AsdOrphans.analyse(directory)
        }
    }
    
    func show(_ orphan: String) {
        guard let directory = directory else { return }
        let url = URL(fileURLWithPath: orphan, relativeTo: URL(fileURLWithPath: directory))
        AsdOrphans.showFile(url)
    }
}

struct AsdView_Previews: PreviewProvider {
    static var previews: some View {
        AsdView()
    }
}
