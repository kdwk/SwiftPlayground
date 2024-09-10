// The Swift Programming Language
// https://docs.swift.org/swift-book

struct Point: CustomStringConvertible {
    var x: Int = 0
    var y: Int = 0
    var description: String {
        "(\(x), \(y))"
    }
}

protocol Fruit: CustomStringConvertible {}

struct Apple: CustomStringConvertible, Fruit {
    private var location: Point = Point()
    var description: String {
        "🍎@\(location)"
    }
    init(x: Int = 0, y: Int = 0) {
        self.location = Point(x: x, y: y)
    }
}

struct Orange: CustomStringConvertible, Fruit {
    private var location: Point = Point()
    var description: String {
        "🍊@\(location)"
    }
    init(x: Int = 0, y: Int = 0) {
        self.location = Point(x: x, y: y)
    }
}

struct Basket: CustomStringConvertible {
    var fruits: [Fruit] = [Apple()]
    var description: String {
        var str = ""
        for (i, fruit) in self.fruits.enumerated() {
            str.append(contentsOf: fruit.description)
            if i != self.fruits.count-1 {
                str.append(contentsOf: ", ")
            }
        }
        return str
    }
    mutating func add(_ fruit: some Fruit) {
        self.fruits.append(fruit)
    }
}

enum Direction: CustomStringConvertible {
    case north
    case east
    case south
    case west
    case polar(degrees: Double)
    var description: String {
        switch self {
            case .north:
                return "North"
            case .east:
                return "East"
            case .south:
                return "South"
            case .west:
                return "West"
            case .polar(let degrees):
                return "\(degrees)°"
        }
    }
}

struct Velocity: CustomStringConvertible {
    var speed: Double
    var direction: Direction
    var description: String {
        "\(speed)m/s \(direction)"
    }
}

enum State: CustomStringConvertible{
    case walking(Velocity)
    case running(Velocity)
    case sitting
    case standing
    var description: String {
        switch self {
            case .walking(let v):
                return "walking with velocity \(v)"
            case .running(let v):
                return "running with velocity \(v)"
            case .sitting:
                return "sitting"
            case .standing:
                return "standing"
        }
    }
}

protocol Automotive {
    mutating func changeState(_ state: State)
}

struct Person: Automotive, CustomStringConvertible {
    var name: String
    private var state: State = .sitting
    private var location = Point()
    private var basket = Basket()
    var description: String {
        "\(name) is currently \(state)"
    }
    init(_ name: String) {
        self.name = name
    }
    mutating func changeState(_ state: State) {
        self.state = state
    }
}

@resultBuilder
struct VecBuilder<T> {
    static func buildBlock(_ components: T...) -> [T] {
        var array: [T] = []
        array.append(contentsOf: components)
        return array
    }
    static func buildArray(_ components: [T]) -> [T] {
        var array: [T] = []
        array.append(contentsOf: components)
        return array
    }
}

func Vec<T>(@VecBuilder<T> contents: ()->[T]) -> [T] {
    return contents()
}

func customIf(condition: Bool, then: () -> (), _ otherwise: (() -> ())?) {
    if condition {
        then()
    } else if let otherwise = otherwise {
        otherwise()
    }
}

func main() {
    let start = "A"
    let goal = "B"
    var (cost, path) = (0, "")
    if #available(macOS 13, *) {
        let clock = ContinuousClock()
        let time = clock.measure {
            (cost, path) = ucsGsa(graph: costly_romania.mapValues {value in value.map {node in Node(cost: node.0, name: node.1)}}, start: start, goal: goal)
        }
        print("Found path \(path) for cost \(cost) in \(time)")
    }
    //let j = Point()
    //let p = Point(x: 3, y: 4)
    //print("\(p) \(j)")
    //var basket = Basket()
    //basket.add(Orange(x: 4, y: 6))
    //print(basket)
    //var kdwk = Person("Kdwk")
    //kdwk.changeState(.running(Velocity(speed: 9.81, direction: .north)))
    //print(kdwk)
}

main()
