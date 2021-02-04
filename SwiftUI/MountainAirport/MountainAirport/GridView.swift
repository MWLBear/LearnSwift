import SwiftUI

struct GridView<Content,T>: View where Content: View{
    let content: (T) -> Content
    
    var columns: Int
    var numberRows: Int {
        (items.count - 1) / columns
    }
    
    var items: [T]
    
    init(colums: Int, items: [T],
         @ViewBuilder content: @escaping (T) -> Content) {
        self.columns = colums
        self.items = items
        self.content = content
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView{
                VStack {
                    ForEach(0...self.numberRows, id:\.self) { row in
                        HStack {
                            ForEach(0..<self.columns, id: \.self) { column in
                                Group {
                                    if self.elementFor(row: row, column: column) != nil {
                                        self.content(self.items[self.elementFor(row: row, column: column)!])
                                            .frame(width: geometry.size.width/CGFloat(self.columns),
                                                   height: geometry.size.width/CGFloat(self.columns))
                                    }else {
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func elementFor(row: Int, column: Int) -> Int? {
        let index = row * self.columns + column
        return index < items.count ? index : nil
    }
    
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(colums: 3, items:[11, 3, 7, 17, 5, 2,1]){item in
            Text("\(item)")
        }
    }
}
