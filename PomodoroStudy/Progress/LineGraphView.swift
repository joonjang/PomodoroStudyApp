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
            let percentageY = 1 - Double(values[i] - minValue) / Double(maxValue - minValue)
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
                    
                    
                    ForEach(graphNodes, id: \.self ) { nodes in
                        if nodes.value  % 5 == 0 {
                            Text("\(nodes.value)")
                                .font(.system(size: 10))
                                .position(x: nodes.point(for: reader.size).x,
                                          y: nodes.point(for: reader.size).y + 15 )
                        }
                    }
                    selectedNodeHighlight(viewSize: reader.size)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
        @ViewBuilder
        func selectedNodeHighlight (viewSize: CGSize) -> some View {
                let point = graphNodes[6].point(for: viewSize)
                ZStack {
                    Circle()
                        .frame (width: 18, height: 18)
                        .foregroundColor(.white.opacity(0.9))
                    Circle()
                        .frame (width: 11, height: 11)
                        .foregroundColor(Color.accentColor)
                }
                .position(x: point.x, y: point.y)
        }
    
}

struct LineGraphView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
