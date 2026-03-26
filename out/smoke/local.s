	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p1"
	.file	"local.ll"
	.globl	f                               # -- Begin function f
	.p2align	2
	.type	f,@function
f:                                      # @f
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	addi	a0, a0, 1
	sd	a0, 8(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end0:
	.size	f, .Lfunc_end0-f
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
