
class shield extends item
    new:(global) =>
        super global
        @onguard = false
    guard:  => 
        if not @onguard then 
            @onguard = true
            @\oneshot 0.8, -> @onguard = false
