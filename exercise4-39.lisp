; We can gain some speed by moving expensive operations (distinct? ...) to the
; bottom. If a cheaper operation fails first, we won't have to execute the
; expensive ones.
