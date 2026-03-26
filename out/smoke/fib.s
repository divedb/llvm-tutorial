	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p1"
	.file	"fib.ll"
	.globl	fib                             # -- Begin function fib
	.p2align	2
	.type	fib,@function
fib:                                    # @fib
	.cfi_startproc
# %bb.0:                                # %entry
	li	a1, 1
	blt	a1, a0, .LBB0_2
# %bb.1:                                # %ret
	ret
.LBB0_2:                                # %recur
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	sd	s1, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	.cfi_offset s1, -24
	addi	a1, a0, -1
	addi	s0, a0, -2
	mv	a0, a1
	call	fib
	mv	s1, a0
	mv	a0, s0
	call	fib
	add	a0, s1, a0
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	ld	s1, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	fib, .Lfunc_end0-fib
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
