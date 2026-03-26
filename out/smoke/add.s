	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p1"
	.file	"add.ll"
	.globl	add                             # -- Begin function add
	.p2align	2
	.type	add,@function
add:                                    # @add
	.cfi_startproc
# %bb.0:                                # %entry
	add	a0, a0, a1
	ret
.Lfunc_end0:
	.size	add, .Lfunc_end0-add
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
