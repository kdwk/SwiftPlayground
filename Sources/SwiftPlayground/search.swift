import Collections

let romania = [ "A":["S","T","Z"],"Z":["A","O"],"O":["S","Z"],"T":["A","L"],"L":["M","T"],"M":["D","L"], "D":["C","M"],"S":["A","F","O","R"],"R":["C","P","S"],"C":["D","P","R"], "F":["B","S"],"P":["B","C","R"],"B":[] ]

func bfsTsa(graph: Dictionary<String, Array<String>>, start: String, goal: String) {
    var frontier: Deque = [start]
    while !frontier.isEmpty {
        let node = frontier.popFirst()!
        for child in romania[node]! {
            if child == goal {
                return
            }
            else {
                frontier.append(child)
            }
        }
    }
}

func bfsGsa(graph: Dictionary<String, Array<String>>, start: String, goal: String) {

}
