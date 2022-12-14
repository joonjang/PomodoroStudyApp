//
//  LineGraphView.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-09-03.
//

import SwiftUI

struct GraphNode: Identifiable, Hashable{
    let id = UUID()
    let value: Int
    let percentageX: Double
    let percentageY: Double
    
    func point (for size: CGSize) -> CGPoint {
        CGPoint(x: size.width * percentageX,
                y: size.height * percentageY)
    }
}

struct LineGraph: Shape {
    let nodes: [GraphNode]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for i in nodes.indices {
            let point = nodes[i].point(for: rect.size)
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        return path
    }
}

struct LineGraphView: View {
    @State private var selectedNode: GraphNode? = nil
    @Binding private var selectedValue: Int?
    
    let graphNodes: [GraphNode]
    
    init(values: [Int], selectedValue: Binding<Int?>) {
        self._selectedValue = selectedValue
        guard let maxValue = values.max(), let minValue = values.min() else {
            graphNodes = [GraphNode]()
            return
        }
        
        var nodes = [GraphNode]()
        for i in values.indices {
            let percentageY = 1 - Double(values[i] - minValue) / (Double(maxValue - minValue) == 0 ? 1 : Double(maxValue - minValue))
            let percentageX = Double(i) / Double(values.count - 1)
            let newNode = GraphNode (value: values[i],
                                     percentageX: percentageX,
                                     percentageY: percentageY)
            nodes.append (newNode)
        }
        self.graphNodes = nodes
    }
    
    var body: some View {
        
        GeometryReader { reader in
            VStack {
                ZStack {
                    LineGraph(nodes: graphNodes)
                        .stroke(Color.green,
                                style: StrokeStyle(lineWidth: 4.5,
                                                   lineCap: .round,
                                                   lineJoin: .round))
                    
                    let uniqueVals = filterUniqueVal(gn: graphNodes)
                    
                    // adjust graph x-axis marking
                    ForEach(uniqueVals, id: \.self ) { nodes in
                        if graphNodes.count < 100 {
                            if nodes.value  % 5 == 0 {
                                Text("\(nodes.value)")
                                    .font(.system(size: 10))
                                    .position(x: nodes.point(for: reader.size).x,
                                              y: nodes.point(for: reader.size).y + 15 )
                            }
                        } else if graphNodes.count < 150 {
                            if nodes.value  % 25 == 0 || nodes.value % 10 == 0 {
                                Text("\(nodes.value)")
                                    .font(.system(size: 10))
                                    .position(x: nodes.point(for: reader.size).x,
                                              y: nodes.point(for: reader.size).y + 15 )
                            }
                        } else {
                            if nodes.value  % 25 == 0 {
                                Text("\(nodes.value)")
                                    .font(.system(size: 10))
                                    .position(x: nodes.point(for: reader.size).x,
                                              y: nodes.point(for: reader.size).y + 15 )
                            }
                        }
                    }
                    selectedNodeHighlight(viewSize: reader.size, sv: selectedValue)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
    func filterUniqueVal (gn: [GraphNode] ) -> [GraphNode] {
        var buffer = [GraphNode]()
        var added = Set<Int>()
        for node in gn {
            if !added.contains(node.value) {
                buffer.append(node)
                added.insert(node.value)
            }
        }
        return buffer
    }
    
//  https://stackoverflow.com/questions/25738817/removing-duplicate-elements-from-an-array-in-swift
//    func unique<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
//        var buffer = [T]()
//        var added = Set<T>()
//        for elem in source {
//            if !added.contains(elem) {
//                buffer.append(elem)
//                added.insert(elem)
//            }
//        }
//        return buffer
//    }
    
    @ViewBuilder
    func selectedNodeHighlight (viewSize: CGSize, sv: Int?) -> some View {
        let point = graphNodes[sv ?? 0].point(for: viewSize)
//        if sv != 0 {
            ZStack {
                Text("\(graphNodes[sv ?? 0].value) min")
                    .font(.system(size: 15))
                    .offset(x: -4, y: -40 )
//                Circle()
//                    .frame (width: 18, height: 18)
//                    .foregroundColor(.white.opacity(0.9))
//                Circle()
//                    .frame (width: 11, height: 11)
//                    .foregroundColor(Color.accentColor)
                
                if graphNodes[sv ?? 0] == graphNodes.last {
                    Image("victory")
                        .resizable()
                        .frame(width:(25),
                               height:25)
                        .offset(y: -15 )

                } else {
                    Image("running")
                        .resizable()
                        .frame(width:(25),
                               height:25)
                        .offset(y: -15 )
                        .rotationEffect(Angle.degrees(-40))
                }
            }
            .animation(.linear(duration: 2), value: graphNodes[sv ?? 0])
            .position(x: point.x, y: point.y)
        }
//    }
    
}

struct LineGraphView_Previews: PreviewProvider {

    static var previews: some View {
        LineGraphView(values: ModelData().progress[0].elapsed, selectedValue: .constant(25))
            .environmentObject(ModelData())
    }
}
