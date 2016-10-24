//
//  Girth Algorithm.swift
//  Girth
//
//  Created by 诸葛俊伟 on 10/23/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import Foundation

public class Node {
    public var vertex: Int
    public var depth: Int
    init(_ vertex: Int, _ depth: Int) {
        self.vertex = vertex
        self.depth = depth
    }
}

func FindGirth(_ graph: [[Int]])
{
    let n = graph.count
    
    // shortest cycle length
    var short = n - 1
    
    var queue = [Node]()
    
    var root = 0
    while (root < n - 2 && short > 3)
    {
        var label = Array(repeating: -1, count: n)
        
        label[root] = 0
        queue.append(Node(root, 0))
        
        var node = queue.removeFirst()
        while (!queue.isEmpty && short > 3 && (node.depth + 1) * 2 - 1 < short)
        {
            let depth = node.depth + 1
            
            // check all neighbours
            for neighbour in getNeighbours(graph, node.vertex)
            {
                // haven't seen this neighbour before
                if label[neighbour] < 0 {
                    queue.append(Node(neighbour, depth))
                    label[neighbour] = depth
                } else if label[neighbour] == depth - 1 {
                    // odd number of edges
                    if depth * 2 - 1 < short {
                        short = depth * 2 - 1
                    }
                } else if label[neighbour] == depth {
                    // even number of edges
                    if (depth * 2 < short) {
                        short = depth * 2
                    }
                }
            }
            node = queue.removeFirst()
        }
        queue.removeAll()
        root += 1
    }
//    return short > 0 ? short : 1
}

func getNeighbours(_ graph: [[Int]], _ vertex: Int) -> [Int]
{
    var res = [Int]()
    for i in 0..<graph.count {
        if graph[vertex][i] != 0 {
            res.append(i)
        }
    }
    
    return res
}
