	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p1"
	.file	"global.ll"
	.globl	f                               # -- Begin function f
	.p2align	2
	.type	f,@function
f:                                      # @f
	.cfi_startproc
# %bb.0:                                # %entry
	lui	a0, %hi(g)
	ld	a0, %lo(g)(a0)
	ret
.Lfunc_end0:
	.size	f, .Lfunc_end0-f
	.cfi_endproc
                                        # -- End function
	.type	g,@object                       # @g
	.section	.sdata,"aw",@progbits
	.globl	g
	.p2align	3, 0x0
g:
	.quad	9                               # 0x9
	.size	g, 8

	.section	".note.GNU-stack","",@progbits
