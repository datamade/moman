# cython: c_string_type=unicode, c_string_encoding=utf8, boundscheck = False, wraparound = False, infer_types = True

cpdef list innerLoop(states, 
                     basestring word, 
                     int n, 
                     dict transitionsStates, 
                     dict fsa_states, 
                     set fsa_finalStates) :

    cdef unicode uword = _ustring(word)

    cdef list words = []
    cdef int window = 2 * n + 1
    cdef int wordLen = len(uword)
    cdef basestring V, q, q1, x
    cdef unicode word_chunk, each
    cdef list stateType, state_type
    cdef dict word_states
    cdef tuple state, all_state, transitions
    cdef int index, new_index, match, cv

    while states :
        all_state = states.pop()
        V, q, stateType, index = all_state

        chunk_size = min(window, wordLen-index)
        word_chunk = uword[index:index+chunk_size]

        word_states = transitionsStates[chunk_size][repr(stateType)]

        for transitions in fsa_states[q].transitions.items():
            x, q1 = transitions
            if x in word_chunk :
                cv = 0
                for each in word_chunk :
                    match = each == x
                    cv = (cv << 1) | match
            else :
                cv = 0
                    
            cv = (cv << 1) | chunk_size
 
            state = word_states[cv]
            state_type, new_index = state
	    
            if state_type :
                states.append((V + x, 
                               q1,
                               state_type,
                               new_index + index))
 

        if q in fsa_finalStates and final(n, 
                                          stateType, 
                                          index, 
                                          wordLen) :
            words.append(V)
        
    return words

cpdef int final(int n, list state, int index, int wordLen):
    cdef int isFinal = False

    cdef int j = 0
    cdef int i, e

    while j < len(state) and isFinal == False:
        i = state[j].i + index
        e = state[j].e
        if wordLen - i + e <= n:
            isFinal = True
        j += 1
    return isFinal

cdef unicode _ustring(basestring s):
    if type(s) is unicode:
        # fast path for most common case(s)
        return <unicode>s
    else : # safe because of basestring
        return <char *>s

