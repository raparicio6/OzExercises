
public class BinarySearchTree {
  private var value: (Character, Int)
  private var parent: BinarySearchTree?
  private var left: BinarySearchTree?
  private var right: BinarySearchTree?

  public init(value: Character) {
    self.value = (Character(String(value).lowercased()), 1)
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
    if val !== nil {
      return val!.value.1
    }

    return 0    
  }

}

extension BinarySearchTree {
  public func map(_ f: ((Character, Int)) -> (Character, Int)) -> [(Character, Int)] {
    var i = [(Character, Int)]()
    if let left = left { i += left.map(f) }
    i.append(f(value))
    if let right = right { i += right.map(f) }
    return i
  }

  public func toArray() -> [(Character, Int)] {
    return map { $0 }
  }

}

extension BinarySearchTree: CustomStringConvertible {
  // para imprimir
  public var description: String {
    var d = ""
    if let left = left {
      d += "(\(left.description)) <- "
    }
    d += "\(value)"
    if let right = right {
      d += " -> (\(right.description))"
    }
    return d
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

func sonAnagramas(_ texto1: String, _ texto2: String) -> Bool {
  var dicc1 = Dictionary.newDicc()
  var dicc2 = Dictionary.newDicc()

  for letra in texto1 {
    dicc1 = dicc1.put(key: letra)    
  }

  for letra in texto2 {
    dicc2 = dicc2.put(key: letra)    
  } 

  return dicc1.equals(dicc2)
}

print(sonAnagramas("quieren", "Enrique")) // true
print(sonAnagramas("necrofila", "Florencia")) // true
print(sonAnagramas("saco", "cosa")) // true
print(sonAnagramas("chau", "hola")) // false
print(sonAnagramas("holaa", "hola")) // false
