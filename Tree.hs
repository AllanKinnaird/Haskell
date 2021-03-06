-- Simple binary tree

data Tree = Leaf | Node Int Tree Tree deriving Show

treeDepth :: Tree -> Int
treeDepth Leaf = 0
treeDepth (Node _ leftSubtree rightSubtree) =
  1 + max (treeDepth leftSubtree) (treeDepth rightSubtree)

treeSum :: Tree -> Int
treeSum Leaf = 0
treeSum (Node nodeVal leftSubtree rightSubtree) =
  nodeVal + (treeSum leftSubtree) + (treeSum rightSubtree)

isSortedTree :: Tree -> Int -> Int -> Bool
isSortedTree Leaf _ _ = True
isSortedTree (Node x leftSubtree rightSubtree) minVal maxVal =
    let leftSorted  = isSortedTree leftSubtree minVal x
        rightSorted = isSortedTree rightSubtree x maxVal
    in x >= minVal && x < maxVal && leftSorted && rightSorted

addNewMax :: Tree -> Tree
-- add a new max element to tree
addNewMax Leaf = Node 0 Leaf Leaf -- input tree with no nodes
addNewMax (Node x t1 Leaf) = Node x t1 (Node (x + 1) Leaf Leaf) -- rightmost branch
addNewMax (Node x t1 t2) = Node x t1 (addNewMax t2) -- go down the right subtree

treeToList :: Tree -> [Int]
-- convert a tree to a list
treeToList Leaf = []
treeToList (Node x br1 br2) = (treeToList br1) ++ [x] ++ (treeToList br2)

addToSortedTree :: Tree -> Int -> Tree
-- insert a new node in a sorted tree (equal nodes inserted chronologically L-R)
addToSortedTree Leaf x = Node x Leaf Leaf
addToSortedTree (Node nodeVal leftBranch rightBranch) x
    | x <  nodeVal = Node nodeVal (addToSortedTree leftBranch x) rightBranch
    | x >  nodeVal = Node nodeVal leftBranch (addToSortedTree rightBranch x)
    | x == nodeVal = Node nodeVal leftBranch (Node x Leaf rightBranch)
