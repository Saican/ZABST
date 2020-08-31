# ZABST
 ZScript AVL Binary Search Tree

- This is a height balancing binary search tree based off of code written for a Unity project in C#.
- The tree is optimized for a game environment.  Node access is done at the insertion node, the tree runs both directions, allowing for balancing without excessive recursion.
- This tree has been coined a "South-Paw" AVL tree due to a slight oversight where left values are positive and right are negative.  This has no impact on performance and is just a slight logic difference; the programmer is left-handed.  PRs attempting to fix this will be denied.
- The tree is unfinished as it is missing a Delete method.  If you'd like to take care of it, please submit a PR.  The method **must** rebalance the tree.
