// https://github.com/raywenderlich/swift-algorithm-club/blob/master/Binary%20Search%20Tree/Solution%201/BinarySearchTree.playground/Sources/BinarySearchTree.swift

/*
  A binary search tree.
  Each node stores a value and two children. The left child contains a smaller
  value; the right a larger (or equal) value.  

  This tree allows duplicate elements.

  Adapté el árbol para poder tener guardar una clave-valor, 
  junto con otras varias modificaciones
*/

public class BinarySearchTree {
  private var value: (Character, Int)
  private var parent: BinarySearchTree?
  private var left: BinarySearchTree?
  private var right: BinarySearchTree?

  public init(value: Character) {
    self.value = (value, 1)
  }

  public convenience init(array: [Character]) {
    precondition(array.count > 0)
    self.init(value: array.first!)
    for v in array.dropFirst() {
      insert(value: v)
    }
  }

  public var isRoot: Bool {
    return parent == nil
  }

  public var isLeaf: Bool {
    return left == nil && right == nil
  }

  public var isLeftChild: Bool {
    return parent?.left === self
  }

  public var isRightChild: Bool {
    return parent?.right === self
  }

  public var hasLeftChild: Bool {
    return left != nil
  }

  public var hasRightChild: Bool {
    return right != nil
  }

  public var hasAnyChild: Bool {
    return hasLeftChild || hasRightChild
  }

  public var hasBothChildren: Bool {
    return hasLeftChild && hasRightChild
  }

  /* How many nodes are in this subtree. Performance: O(n). */
  public var count: Int {
    return (left?.count ?? 0) + 1 + (right?.count ?? 0)
  }
}

// MARK: - Adding items
extension BinarySearchTree {
  /*
    Inserts a new element into the tree. You should only insert elements
    at the root, to make to sure this remains a valid binary tree!
    Performance: runs in O(h) time, where h is the height of the tree.
  */
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

// MARK: - Deleting items
extension BinarySearchTree {
  /*
    Deletes a node from the tree.
    Returns the node that has replaced this removed one (or nil if this was a
    leaf node). That is primarily useful for when you delete the root node, in
    which case the tree gets a new root.
    Performance: runs in O(h) time, where h is the height of the tree.
  */
  @discardableResult public func remove() -> BinarySearchTree? {
    let replacement: BinarySearchTree?

    // Replacement for current node can be either biggest one on the left or
    // smallest one on the right, whichever is not nil
    if let right = right {
      replacement = right.minimum()
    } else if let left = left {
      replacement = left.maximum()
    } else {
      replacement = nil
    }

    replacement?.remove()

    // Place the replacement on current node's position
    replacement?.right = right
    replacement?.left = left
    right?.parent = replacement
    left?.parent = replacement
    reconnectParentTo(node:replacement)

    // The current node is no longer part of the tree, so clean it up.
    parent = nil
    left = nil
    right = nil

    return replacement
  }

  private func reconnectParentTo(node: BinarySearchTree?) {
    if let parent = parent {
      if isLeftChild {
        parent.left = node
      } else {
        parent.right = node
      }
    }
    node?.parent = parent
  }
}

// MARK: - Searching
extension BinarySearchTree {
  /*
    Finds the "highest" node with the specified value.
    Performance: runs in O(h) time, where h is the height of the tree.  
  */
  public func search(_ value: Character) -> BinarySearchTree? {
    if value < self.value.0 {
      return left?.search(value)
    } else if value > self.value.0 {
      return right?.search(value)
    } else {
      return self  // found it!
    }
  }  

  public func contains(value: Character) -> Bool {
    return search(value) != nil
  }

  /*
    Returns the leftmost descendent. O(h) time.
  */
  public func minimum() -> BinarySearchTree {
    var node = self
    while let next = node.left {
      node = next
    }
    return node
  }

  /*
    Returns the rightmost descendent. O(h) time.
  */
  public func maximum() -> BinarySearchTree {
    var node = self
    while let next = node.right {
      node = next
    }
    return node
  }

}

// MARK: - Debugging
extension BinarySearchTree: CustomStringConvertible {
  public var description: String {
    var s = ""
    if let left = left {
      s += "(\(left.description)) <- "
    }
    s += "\(value.0)"
    if let right = right {
      s += " -> (\(right.description))"
    }
    return s
  }  

}


// -----------------------------------------------------

struct Dictionary {
    private var tree: BinarySearchTree?

    init() {        
      self.tree = nil
    }
    
    mutating func set(key: Character) -> Dictionary {      
      if self.tree === nil {
        self.tree = BinarySearchTree(value: (key))
      } else {
        self.tree!.insert(value: key)
      }

      var newDict = Dictionary()
      newDict.tree = self.tree
      return newDict      
    }    
    
    //func get(key: Character) -> Int? {
      
    //}
    
    /*subscript(key: Character) -> Int? {
      get {
        return get(key: key)
      }
      set {
        return set(key: key, value: newValue)
      }
    }*/
}

let tree = BinarySearchTree(value: ("d"))
tree.insert(value: ("e"))
tree.insert(value: ("b"))
tree.insert(value: ("a"))
tree.insert(value: ("c"))
tree.insert(value: ("f"))

print(tree)


/* 
actualizar el arbol con el item que me dan, 
y crear un nuevo diccionario con ese arbol actualizado

propiedades privadas
todo dentro de la clase
*/