
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
    } else {      
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

  public func contains(value: Character) -> Bool {
    return search(value) != nil
  }

  public func getIntOfValue(value: Character) -> Int? {
    let val = search(value) 
    if val != nil {
      return val!.value.1
    }

    return nil    
  }
  
  public func minimum() -> BinarySearchTree {
    var node = self
    while let next = node.left {
      node = next
    }
    return node
  }
  
  public func maximum() -> BinarySearchTree {
    var node = self
    while let next = node.right {
      node = next
    }
    return node
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

    public init() {        
      tree = nil
    }
    
    public func put(key: Character) -> Dictionary {
      var newTree: BinarySearchTree
      if (tree === nil){
        newTree = BinarySearchTree(value: key)
      } else {
        newTree = tree!.copy()
        newTree.insert(value: key)
      }    

      var newDict = Dictionary()
      newDict.tree = newTree
      return newDict      
    }    
    
    public func get(key: Character) -> Int? {
      if (tree === nil){
        return 0
      }        

      return tree!.getIntOfValue(value: key)
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

print(tree)

let arr = "ddagfza"

var aa = Dictionary()

for letra in arr {
  aa = aa.put(key: letra)  
  print(aa) 
}

print(aa.get(key: "f"))


/* 
actualizar el arbol con el item que me dan, 
y crear un nuevo diccionario con ese arbol actualizado

propiedades privadas
todo dentro de la clase
*/