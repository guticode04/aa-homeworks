
# O(n^2) => quadratic

def sluggish_octopus(fishes)
  longest = ""
  (0...fishes.length).each do |idx1|
    (idx1 + 1...fishes.length).each do |idx2|
      if fishes[idx1].length > fishes[idx2].length
        longest = fishes[idx1]
      else
        longest = fishes[idx2]
      end
    end
  end
  longest
end


#O(nlogn)
#Dominant Octopus
def merge_sort(array, &prc)
  prc ||= Proc.new { |ele1,ele2| ele1 <=> ele2 }

  return array if array.length < 2

  mid = array.length/2
  left = array.take(mid)
  right = array.drop(mid)

  sorted_left = merge_sort(left,&prc)
  sorted_right = merge_sort(right,&prc)

  merge(sorted_left,sorted_right,&prc)
end

def merge(left,right,&prc)

  merged = []

  until left.empty? || right.empty?
    case prc.call(left.first,right.first)
    when -1
      merged << left.shift
    when 0
      merged << left.shift
    when 1
      merged << right.shift
    end
  end

   merged + left + right 

end

#O(n)
def clever_octopus(fishes)
  longest = fishes.first
  fishes.each do |fish|
    longest = fish if fish.length > longest.length
  end
  longest
end


def slow_dance_octopus(direction, tiles_array)
  tiles_array.each_with_index do |tile, index|
    return index if tile == direction
  end
end

octopus_dance_moves = {
    "up" => 0,
    "right-up" => 1,
    "right"=> 2,
    "right-down" => 3,
    "down" => 4,
    "left-down" => 5,
    "left" => 6,
    "left-up" => 7
}

def fast_dance_octopus(direction, tiles_hash)
  octopus_dance_moves[direction]
end