	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p1"
	.file	"sum_loop.ll"
	.globl	sum                             # -- Begin function sum
	.p2align	2
	.type	sum,@function
sum:                                    # @sum
	.cfi_startproc
# %bb.0:                                # %entry
	li	a1, 0
	beqz	a0, .LBB0_2
.LBB0_1:                                # %body
                                        # =>This Inner Loop Header: Depth=1
	add	a1, a1, a0
	addi	a0, a0, -1
	bnez	a0, .LBB0_1
.LBB0_2:                                # %exit
	mv	a0, a1
	ret
.Lfunc_end0:
	.size	sum, .Lfunc_end0-sum
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
