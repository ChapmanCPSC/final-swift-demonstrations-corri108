//Assignment 1
//Will Corrin
//CPSC-370

//basic human class. dead when optional type age? is nil.
class Human
{
    //properties
    var name : String = ""
    var health : Int = 100
    var age : Int? = nil
    //make GOD static...because there is only one God!
    static var GOD : Human? = nil
    
    //constructor
    init(firstName : String)
    {
        self.name = firstName
    }
    
    //gets whether this human is dead or not
    var dead: Bool
        {
        get
        {
            return age == nil
        }
    }
    
    //spawns this human
    func Spawn(tAge : Int, tHealth : Int)
    {
        health = tHealth
        age = tAge
    }
    
    //prints weather this human is alive or not
    func PrintStatus()
    {
        if(dead)
        {
            print(name + " is dead.")
        }
        else
        {
            print(name + " is alive.")
        }
    }
}

//baby class that derives from human
class Baby : Human
{
    override init(firstName : String)
    {
        super.init(firstName: firstName)
        self.Spawn(1,tHealth: 20)
    }
    
    func BabyDie()
    {
        age = nil
    }
}

//basic square class to show functionality of doing things inside set{}
class Square
{
    init(sl : Double)
    {
        self.sideLength = sl
    }
    
    var sideLength : Double = 1
    var perimeter: Double
        {
        get
        {
            return 4.0 * sideLength
        }
        set
        {
            sideLength = newValue / 4.0
        }
    }
    
    func PrintPerim()
    {
        print("Perimeter: " + "\(perimeter)")
    }
}

//custom exception
enum AgeException : ErrorType
{
    case Err
}

//error handling, guard unwrapping
func PrintAgeOf(hum : Human) throws -> String
{
    guard let age = hum.age else
    {
        throw AgeException.Err
    }
    
    if(hum.age >= 1000)
    {
        return "It is God! No one else is 1000 years old!"
    }
    
    return "Human " + hum.name + " is \(age) years old."
}

func CreateGod()->Human
{
    let god = Human(firstName: "God")
    god.Spawn(1000, tHealth: 1000)
    return god
}

func TryPrint(hum : Human) throws
{
    do
    {
        try print(PrintAgeOf(hum))
    }
    catch AgeException.Err
    {
        print(hum.name + "\'s age cannot be gotten because " + hum.name + " is dead.")
    }
}

//begin actual testing of classes and functions
Human.GOD = CreateGod()

//should be dead, then alive
var will = Human(firstName: "Will")
will.PrintStatus()
will.Spawn(20, tHealth: 100)
will.PrintStatus()

//should be alive, then dead
var bab = Baby(firstName: "Mark")
bab.PrintStatus()
bab.BabyDie()
bab.PrintStatus()

//make squares array of varying length, iterate through
var squares = [Square]()
squares.append(Square(sl: 7))
squares.append(Square(sl: 3))
squares.append(Square(sl: 5))
squares.append(Square(sl: 1))

//for loop of perimeters: 28, 12, 20, 4
for sq in squares
{
    sq.PrintPerim()
}

//different kind of for loop
for i in 1...10
{
    print("i * i = " + "\(i * i)")
}

try TryPrint(will)
try TryPrint(bab)
//unwrap GOD - we know he must be initialized!
try TryPrint(Human.GOD!)

