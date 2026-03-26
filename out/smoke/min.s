	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p1"
	.file	"min.ll"
	.globl	min                             # -- Begin function min
	.p2align	2
	.type	min,@function
min:                                    # @min
	.cfi_startproc
# %bb.0:                                # %entry
	blt	a0, a1, .LBB0_2
# %bb.1:                                # %entry
	mv	a0, a1
.LBB0_2:                                # %entry
	ret
.Lfunc_end0:
	.size	min, .Lfunc_end0-min
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
