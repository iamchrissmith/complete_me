def find_letters(letters, suggestion = [''])
  this_letter = letters[0]
  if find_node(this_letter)
    index = find_node(this_letter)
    # need to remove first letter and move to next level
  elsif !letters.empty?
    return suggestion = ["No Suggestions"]
  end
  # binding.pry
  if letters.empty?
    suggestion = branch_suggestions(suggestion)
    suggestion = children.map.with_index do |child,idx|
      # binding.pry
      child.add_suggestion_letter(child.letter, suggestion.flatten, idx)
    end
  end
  suggestion
end

def branch_suggestions(suggestion, children = @children)
  # binding.pry
  return suggestion if children.empty?
  num_children = children.length - 1
  current = suggestion[0]
  num_children.times do
    suggestion << current
  end
  suggestion
end

def add_suggestion_letter(letter, suggestion, letters = [])
  suggestion = suggestion.map do |idea|
    # binding.pry
    idea += letter
  end
  find_letters(letters, suggestion)
end
# # binding.pry
#
#
#   # binding.pry
#   suggestion = children.map do |child|
#     binding.pry
#     add_suggestion_letter(child.letter, suggestion)
#   end
# end
# # suggestions = populate_suggestions(suggestions)
# suggestion.flatten

def populate_suggestions(suggestion, children = @children)
#   num_children = children.length
#
#
#     child.populate_suggestions(suggestion)
#
end

# Send letters to head
# Node sees if it has first letter
# - if not, while still letters, return "No suggestions"
# - if it does, add that letter to our results array and pass the remaining string to appropriate child
# - if a node finds the last letter
# -- append our results string to each childs letter
# -- pass the new results array to each child and continue appending
# -- until no children found
# -- return results up the chain (may need to just assign to parent.suggestion)
