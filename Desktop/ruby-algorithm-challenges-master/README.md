# Ruby on Rails 
## Algorithm Practice & Challenges
### Binary Search Trees in Ruby
#### The BST is made up of nodes that have three main features:
 1.They contain a value
 2.They can refer to another node to the left with a smaller value
 3.They can refer to another node to the right with a larger value
#### Implementation :
 My first implementation of this had an overarching Tree class, but it soon became clear that it’s entirely unccessary. As a 
 recursive data structure, each node has a tree descending from it, so we just need a Node. The tree will be implied.

```bash
 module BinaryTree
  class Node
    # our three features:
    attr_reader :value
    attr_accessor :left, :right

    def initialize(v)
      @value = v
    end
  end
end

tree       = BinaryTree::Node.new(10)
tree.left  = BinaryTree::Node.new(5)
tree.right = BinaryTree::Node.new(15)
puts tree.inspect
#<BinaryTree::Node:0x007f9ce207a770 @value=10, 
# @left=#<BinaryTree::Node:0x007f9ce207a748 @value=5>, 
# @right=#<BinaryTree::Node:0x007f9ce207a720 @value=15>>
```

Great! But also: awful. Instead of constructing the tree manually, we need to be able to treat it as if it were an array. We should be able to apply the shovel operator to the base node of the tree and have the tree place the value wherever it should rightfully or leftfully go.

```bash
 module BinaryTree
  class Node
    def insert(v)
      case value <=> v
      when 1 then left.insert(v)
      when -1 then right.insert(v)
      when 0 then false # the value is already present
      end
    end
  end
end
```

This uses Ruby’s spaceshipesque comparator <=> to determine if the value to be inserted is greater than, less than, or equal to the value of the current node, and then traverses the tree until …
 
```bash

tree.insert(3)
# => binary_tree.rb:13:in `insert': undefined method `insert' for nil:NilClass (NoMethodError)
```

Spectacular! Except: not. We have a node that expected its left value to respond to insert, to which nil annoyingly refused. We can redefine more specific insert methods to work around this issue (and, since it’s getting a bit hard to read, a new inspect method):

```bash
module BinaryTree
  class Node
    def insert(v)
      case value <=> v
      when 1 then insert_left(v)
      when -1 then insert_right(v)
      when 0 then false # the value is already present
      end
    end

    def inspect
      "{#{value}::#{left.inspect}|#{right.inspect}}"
    end

    private

      def insert_left(v)
        if left
          left.insert(v)
        else
          self.left = Node.new(v)
        end
      end

      def insert_right(v)
        if right
          right.insert(v)
        else
          self.right = Node.new(v)
        end
      end
  end
end

tree.insert(3)
# => {10:{5:{3:nil|nil}|nil}|{15:nil|nil}}
```
The next step is to determine whether our tree contains a given value. This is where the Binary Search Tree has a reputation for speediness – unlike iterating over every element of an array and checking for equality, the structure of the tree provides a sort of automatic index that points us to where the value should be, and then we can check if it’s there. It’ll look remarkably similar to our insert method:

```bash
module BinaryTree
  class Node

    # named include? to parallel Array#include?
    def include?(v)
      case value <=> v
      when 1 then left.include?(v)
      when -1 then right.include?(v)
      when 0 then true # the current node is equal to the value
      end
    end
  end
end
```
If you were paying attention to the insert method, you can probably guess that when this method reaches a left or right that is nil, it will fail. Which is really annoying! But since this seems to be a pattern we have stumbled upon, let’s find a better way to solve this rather than peppering the code with nil checks. Enter our second class, EmptyNode:

```bash

module BinaryTree
  class EmptyNode
    def include?(*)
      false
    end

    def insert(*)
      false
    end

    def inspect
      "{}"
    end
  end
end

```

…and make sure instances of this class terminate our tree by default:

```bash
module BinaryTree
  class EmptyNode
    def initialize(v)
      @value = v
      @left  = EmptyNode.new
      @right = EmptyNode.new
    end
  end
end

happy = BinaryTree.new(10).left #=> 

```
Note: the (*) formal argument to these EmptyNode’s methods simply states that we don’t care how many arguments are passed to the method, and that we won’t be using them anyway.

The EmptyNode class is useful in that it provides a meaningful end to the recursive structure — specifically, that a given range of values in the tree are definitively not present. Otherwise, it does very little. We don’t allow insert to do anything with it, because then it wouldn’t be an empty node. Unfortunately, we can’t simply tell it to replace itself with a Node object (as that isn’t possible in Ruby), so we have to change the reference back at the parent node:

```bash

module BinaryTree
  class Node
    private
      def insert_left(v)
        left.insert(v) or self.left = Node.new(v)
      end

      def insert_right(v)
        right.insert(v) or self.right = Node.new(v)
      end

  end
end

```

Here, we use the or control flow operator to perform one of two actions: if the first returns a falsey value, the second (assign the new Node object).

Ok! So we now have a binary tree that can insert new values at the correct location and tell you whether or not it contains a given value. Let’s check it out:

```bash

tree = BinaryTree::Node.new(10)               #=> {10:{}|{}}
[5, 15, 3].each {|value| tree.insert(value) } #=> {10:{5:{3:{}|{}}|{}}|{15:{}|{}}}
puts tree.include?(10) #=> true
puts tree.include?(15) #=> true
puts tree.include?(20) #=> false
puts tree.include?(3)  #=> true
puts tree.include?(2)  #=> false

```
#### Benchmarks :
 Let’s benchmark it! This test populates an array with 5000 random values up to 50,000, that checks every value between 1 and 50,000 to see if the array includes it. The same benchmark is repeated for the binary tree containing an identical set of values.

```bash
require 'benchmark'

test_array = []
5000.times { test_array << (rand 50000) }

tree = BinaryTree::Node.new(test_array.first)
test_array.each {|value| tree.insert(value) }

Benchmark.bm do |benchmark|
  benchmark.report("test_array include"){ (1..50000).each {|n| test_array.include? n } }
  benchmark.report("binary tree search"){ (1..50000).each {|n| tree.include? n } }
end

```

```bash

 user     system      total        real
test_array include 13.230000   0.020000  13.250000 ( 13.283172)
binary tree search  0.140000   0.000000   0.140000 (  0.139983)

```

I have to say, I was a little surprised how much faster (~100x) this was. It makes sense when you think about the fact that to check if an element is included in the Array, Ruby needs to run an equality comparison for up to 5000 values 50000 times. That’s a lot of overhead, and Arrays simply aren’t optimized for this. Ruby has another built-in data structure that is explicitly designed for fast lookups of arbitrary values — the venerable Hash. Similar to a binary search tree, Ruby’s hash tables follow a defined set of rules that guide it to the proper places in memory when setting and retrieving values. For an in-depth exploration of what makes Hashes fast, read Pat Shaughnessy’s Ruby Under a Microscope.

Let’s rerun the benchmark again, but this time comparing hash lookups as well. For these purposes, it doesn’t matter what the values are in the hash, so we’ll just make them all true:

```bash
test_hash = Hash[test_array.map {|x| [x, true] }]

Benchmark.bm do |benchmark|
  benchmark.report("test_array include"){ (1..50000).each {|n| test_array.include? n } }
  benchmark.report("binary tree search"){ (1..50000).each {|n| tree.include? n } }
  benchmark.report("test_hash lookup"  ){ (1..50000).each {|n| hash.has_key? n } }
end
```

Ruby’s native C-implemented Hash is around 15 times faster than the Ruby-implemented binary search tree, which is about what I expected.


#### Array Conversions :

In order to convert arrays into binary trees and back again, let’s introduce a few new methods. The first will be a module method:

```bash

module BinaryTree
  def self.from_array(array)
    Node.new(array.first).tap do |tree|
      array.each {|v| tree.insert v }
    end
  end
end

```

from_array simply assigns the root node of the tree as the first value of the array, then pushes all array values on in order. Converting back to an array is a simple matter of traversing the recursive tree. An interesting side effect is that if done in a particular way, this is equivalent to calling .uniq.sort on the original array (as far as I know, it’s impossible to maintain the original order).

```bash
module BinaryTree
  class Node
    def to_a
      left.to_a + [value] + right.to_a
    end
  end

  class EmptyNode
    # unsurprisingly, an empty node returns an empty array
    def to_a
      []
    end
  end
end
```

In case it’s not clear how the recursion works, here’s what the array expansion looks like for a simple tree {10:{5:{}|{}}|{15:{}|{}}}:

1)For both 5 and 15, left.to_a and right.to_a are [] (EmptyNode#to_a), so the results are [5] and [15] respectively

2)For 10, left.to_a is [5] and right.to_a is [15], giving [5] + [10] + [15] or [5, 10, 15]

We can test it on an example with more elements:

```bash

array = [51, 88, 62, 68, 98, 93, 51, 67, 91, 4, 34]
tree = Binary.from_array(array)
# => {51:{4:{}|{34:{}|{}}}|{88:{62:{}|{68:{67:{}|{}}|{}}}|{98:{93:{91:{}|{}}|{}}|{}}}}
tree.to_a #=> [4, 34, 51, 62, 67, 68, 88, 91, 93, 98]

```

Interestingly, it’s faster to convert a large array into a binary tree and perform a search than it is to call include? on the Array.

```bash
array = 5000.times.map { rand 50000 }

Benchmark.bm do |benchmark|
  benchmark.report("array#include?") { (1..50000).each {|v| array.include?(v) }}
  benchmark.report("binary search") do
    tree = BinaryTree.from_array(array)
    (1..50000).each {|v| tree.include?(v) }
  end
end
```
```bash
user     system      total        real
array#include? 13.160000   0.020000  13.180000 ( 13.235368)
binary search   0.190000   0.000000   0.190000 (  0.188989)
```

It takes about 50% longer than just the binary tree search itself, which makes sense because it traverses the tree twice (once to insert values and once to query them). It doesn’t take twice as long, because we start with a small tree (a single node) and build it up gradually as the values are inserted.

#### Why would I use this?

Because of nerdliness?

Honestly cannot think of an instance where this would have been useful to me in a Ruby project, including those where I’m juggling querying enormous quantities of data. 🤷🏻‍♀️👩‍💻


