require 'set'

class GraphNode

  attr_accessor :neighbors
  attr_reader :value

  def initialize (value)

    @value = value
    @neighbors = []

  end
  
  def add_neighbor(neighbor)
    self.neighbors << neighbor
  end

  def bfs(start_node, target_node)
    queue = [start_node]
    visited_nodes = Set.new()

    until queue.empty?
      node = queue.shift
      unless visited.include?(node)
        return node.val if node.val == target_value
        visited_nodes.add(node)
        queue += node.neighbors
      end
    end

    nil

  end

end