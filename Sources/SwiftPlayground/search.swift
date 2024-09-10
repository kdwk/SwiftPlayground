import Collections

let romania = [ "A":["S","T","Z"],"Z":["A","O"],"O":["S","Z"],"T":["A","L"],"L":["M","T"],"M":["D","L"], "D":["C","M"],"S":["A","F","O","R"],"R":["C","P","S"],"C":["D","P","R"], "F":["B","S"],"P":["B","C","R"],"B":[] ]
let costly_romania = [ "A":[(140,"S"),(118,"T"),(75,"Z")],"Z":[(75,"A"),(71,"O")],"O":[(151,"S"),(71,"Z")], "T":[(118,"A"),(111,"L")],"L":[(70,"M"),(111,"T")],"M":[(75,"D"),(70,"L")], "D":[(120,"C"),(75,"M")],"S":[(140,"A"),(99,"F"),(151,"O"),(80,"R")], "R":[(146,"C"),(97,"P"),(80,"S")],"C":[(120,"D"),(138,"P"),(146,"R")], "F":[(211,"B"),(99,"S")],"P":[(101,"B"),(138,"C"),(97,"R")],"B":[]]

func bfsTsa(graph: [String: [String]], start: String, goal: String) -> String {
    var frontier: Deque = [start]
    while !frontier.isEmpty {
        let path = frontier.popFirst()!
        let last = String(path.last!)
        if last == goal {
            return path
        }
        for child in romania[String(path.last!)]! {
            frontier.append(path + child)
        }
    }
    return ""
}

func bfsGsa(graph: [String: [String]], start: String, goal: String) -> String {
    var frontier: Deque = [start]
    var explored: Set<String> = []
    while !frontier.isEmpty {
        let path = frontier.popFirst()!
        let last = String(path.last!)
        if last == goal {
            return path
        }
        if !explored.contains(last) {
            explored.insert(last)
            for child in romania[String(path.last!)]! {
                frontier.append(path + child)
            }
        }
    }
    return ""
}

func dfsTsa(graph: [String: [String]], start: String, goal: String) -> String {
    var frontier: Deque = [start]
    while !frontier.isEmpty {
        let path = frontier.popLast()!
        let last = String(path.last!)
        if last == goal {
            return path
        }
        for child in graph[String(path.last!)]! {
            frontier.append(path + child)
        }
    }
    return ""
}

func dfsGsa(graph: [String: [String]], start: String, goal: String) -> String {
    var frontier: Deque = [start]
    var explored: Set<String> = []
    while !frontier.isEmpty {
        let path = frontier.popLast()!
        let last = String(path.last!)
        if last == goal {
            return path
        }
        if !explored.contains(last) {
            explored.insert(last)
            for child in graph[last]! {
                frontier.append(path + child)
            }
        }
    }
    return ""
}

func ucsGsa(graph: [String: [Node]], start: String, goal: String) -> (Int, String) {
    var frontier: Heap = [Node(cost: 0, name: start)]
    var explored: Set<String> = []
    while !frontier.isEmpty {
        let path = frontier.popMin()!
        let last = String(path.name.last!)
        if last == goal {
            return (path.cost, path.name)
        }
        if !explored.contains(last) {
            explored.insert(last)
            for child in graph[last]! {
                frontier.insert(Node(cost: path.cost + child.cost, name: path.name + child.name))
            }
        }
    }
    return (0, "")
}

struct Node: Comparable {
    let cost: Int
    let name: String
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.cost < rhs.cost
    }
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.cost == rhs.cost
    }
}