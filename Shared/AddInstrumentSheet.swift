import SwiftUI

struct AddInstrumentSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var showing: Bool
    @State var name = ""
    @State var strings: Int16 = 6
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Name", text: $name)
                    }
                    
                    Stepper(
                        "\(strings) strings",
                        value: $strings,
                        in: 2...20
                    )
                }
                
                Button(action: {
                    let instrument = Instrument(context: viewContext)
                    instrument.id = UUID()
                    instrument.name = name
                    instrument.strings = strings
                    instrument.tunings = NSOrderedSet()
                    
                    try? viewContext.save()
                    showing = false
                }) {
                    Text("Add instrument")
                }
            }
            .navigationBarTitle("Add instrument")
            .toolbar(content: {
                Button(action: { showing = false }) {
                    Text("Cancel")
                }
            })
        }
    }
}

struct AddInstrumentSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddInstrumentSheet(showing: Binding.constant(true))
    }
}
