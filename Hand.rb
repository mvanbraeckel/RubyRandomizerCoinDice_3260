#!/usr/bin/ruby

require "./RandomizerContainer.rb"

# Hand <Inherits from RandomizerContainer>
# -> next() : removes and returns the last objected added; if no objects stored, return nil
# -> empty() : returns nil (items are "dropped on the ground") i.e. the pointers to the contained objects are lost (and the objects will be garbage collected by the system)
# Note: All RandomizerContainer objects are created empty. Therefore they are just called with 'new' (e.g. `Cup.new`)
class Hand < RandomizerContainer
    def next
        @randomizers.pop
    end
end
