class PolyTreeNode
    attr_reader :parent, :children, :value

    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent=(node)
        @parent.remove_child(self) if !@parent.nil? and !node.nil? and @parent.value != node.value
        @parent = node
        @parent.add_child(self) if !@parent.nil? and @parent.children.index(self).nil? 
    end

    def add_child(node)
        @children << node
        node.parent = self if node.parent.nil?
    end

    def remove_child(node)
        values = @children.map(&:value)
        node_index = values.index(node.value)
        if !node_index.nil?
            deleted = @children.delete_at(node_index)
            deleted.parent = nil
        else
            raise Exception.new "#{node.value} is not a child of #{self.value}"
        end
    end
    
    def dfs(val)
        return self if self.value== val
        self.children.each do |child|
            result = child.dfs(val)
            return result if !result.nil?
        end
        return nil
    end

    def bfs(val)
        queue = [self]
        until queue[0].value == val
            node = queue.shift
            node.children.each { |child| queue.push(child) }
            return nil if queue.empty?
        end
        queue[0]
    end

    def inspect
        'Node: ' + @value.to_s
    end
end