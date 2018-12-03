
public class BinarySearchTree {
  private var value: (Character, Int)
  private var parent: BinarySearchTree?
  private var left: BinarySearchTree?
  private var right: BinarySearchTree?

  public init(value: Character) {
    self.value = (value, 1)
  }

  private convenience init(value: (Character, Int), parent: BinarySearchTree?, left: BinarySearchTree?, right: BinarySearchTree?) {
    self.init(value: value.0) // esto es porque obliga a pasar por el init siempre
    self.value = value
    self.parent = parent
    self.left = left
    self.right = right
  }

  public func copy() -> BinarySearchTree
  {    
    return BinarySearchTree(value: self.value, parent: self.parent, left: self.left, right: self.right)
  }

}

extension BinarySearchTree {  
  public func insert(value: Character) {
    if value < self.value.0 {
      if let left = left {
        left.insert(value: value)
      } else {
        left = BinarySearchTree(value: value)
        left?.parent = self
      }
    } else if value > self.value.0 {
      if let right = right {
        right.insert(value: value)
      } else {
        right = BinarySearchTree(value: value)
        right?.parent = self
      }
    } else { // ya existe, le sumo uno al segundo elemento de la tupla
      self.value = (self.value.0, (self.value.1) + 1)
    }
  }

}

extension BinarySearchTree {  
  public func search(_ value: Character) -> BinarySearchTree? {
    if value < self.value.0 {
      return left?.search(value)
    } else if value > self.value.0 {
      return right?.search(value)
    } else {
      return self
    }
  }  

  public func getIntOfValue(value: Character) -> Int? {
    let val = search(value) 
    if val != nil {
      return val!.value.1
    }

    return 0    
  }

}

extension BinarySearchTree {
  public func map(_ f: ((Character, Int)) -> (Character, Int)) -> [(Character, Int)] {
    var a = [(Character, Int)]()
    if let left = left { a += left.map(f) }
    a.append(f(value))
    if let right = right { a += right.map(f) }
    return a
  }

  public func toArray() -> [(Character, Int)] {
      return map { $0 }
  }

}

extension BinarySearchTree: CustomStringConvertible {
  // para imprimir
  public var description: String {
    var s = ""
    if let left = left {
      s += "(\(left.description)) <- "
    }
    s += "\(value)"
    if let right = right {
      s += " -> (\(right.description))"
    }
    return s
  } 

}

// -----------------------------------------------------

struct Dictionary {
  private var tree: BinarySearchTree?

  private init() {        
    tree = nil
  }

  public static func newDicc() -> Dictionary{
    return Dictionary()
  }
    
  public func put(key: Character) -> Dictionary {
    var newTree: BinarySearchTree
    if (tree === nil){
      newTree = BinarySearchTree(value: key)
    } else {
      newTree = tree!.copy()
      newTree.insert(value: key)
    }    

    var newDict = Dictionary.newDicc()
    newDict.tree = newTree
    return newDict      
  }    
    
  public func get(key: Character) -> Int {
    if (tree === nil){
      return 0
    }        

    return tree!.getIntOfValue(value: key)!
  }    

  public func equals(_ dictionary: Dictionary) -> Bool {
    if (tree === nil){
      if (dictionary.tree === nil){
        return true
      }
      return false
    }

    if (dictionary.tree === nil){
      return false
    }

    var arr1 = tree!.toArray()
    var arr2 = dictionary.tree!.toArray()

    if (arr1.count != arr2.count) {
      return false
    }      

    arr1 = tree!.toArray().sorted(by: { $0.0 < $1.0 })
    arr2 = dictionary.tree!.toArray().sorted(by: { $0.0 < $1.0 })    

    for index in 0...arr1.count - 1 {
      if arr1[index].0 == arr2[index].0 && arr1[index].1 == arr2[index].1{
        continue
      }        
      
      return false
    }

    return true    
  }   

}

let tree = BinarySearchTree(value: ("d"))
tree.insert(value: ("e"))
tree.insert(value: ("b"))
tree.insert(value: ("a"))
tree.insert(value: ("c"))
tree.insert(value: ("f"))
tree.insert(value: ("e"))
tree.insert(value: ("a"))

let arr = "ddagfzaz"

var dic1 = Dictionary.newDicc()
var dic2 = Dictionary.newDicc()

for letra in arr {
  dic1 = dic1.put(key: letra)
  dic2 = dic2.put(key: letra)  
}

dic2 = dic2.put(key: "a")

print(dic1.equals(dic2))



/* 
actualizar el arbol con el item que me dan, 
y crear un nuevo diccionario con ese arbol actualizado

propiedades privadas
todo dentro de la clase
*/