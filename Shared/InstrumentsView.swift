import SwiftUI
import CoreData

struct InstrumentsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Instrument.entity(),
        sortDescriptors: []
    ) var instruments: FetchedResults<Instrument>
    @State var showingAddSheet = false
    @State var editMode = EditMode.inactive
    
    func onDelete(offsets: IndexSet) {
        offsets.forEach({ index in
            viewContext.delete(instruments[index])
        })
        
        try? viewContext.save()
    }
    
    var body: some View {
        List {
            ForEach(instruments, id: \.self) { instrument in
                NavigationLink(destination: EmptyView()) {
                    Text(instrument.name!)
                }
            }
            .onDelete(perform: onDelete)
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Instruments")
        .toolbar(content: {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                EditButton()
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { showingAddSheet = true }) {
                    Image(systemName: "plus")
                        .font(Font.system(.title))
                }
            }
        })
        .sheet(isPresented: $showingAddSheet, content: {
            AddInstrumentSheet(showing: $showingAddSheet)
        })
        .environment(\.editMode, $editMode)
    }
}

struct InstrumentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InstrumentsView()
                .environment(
                    \.managedObjectContext,
                    PersistenceController.preview.container.viewContext
                )
        }
    }
}
