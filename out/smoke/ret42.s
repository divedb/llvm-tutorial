	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p1"
	.file	"ret42.ll"
	.globl	f                               # -- Begin function f
	.p2align	2
	.type	f,@function
f:                                      # @f
	.cfi_startproc
# %bb.0:                                # %entry
	li	a0, 42
	ret
.Lfunc_end0:
	.size	f, .Lfunc_end0-f
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
