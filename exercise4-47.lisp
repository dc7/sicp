; Since we don't consume any input before branching, once we run out of valid
; matches we'll loop infinitely. If we switch the arms of the amb, we
; immediately loop infinitely.
