; RUN: llc -march=myriscv -mattr=+rv64i < %s | FileCheck %s

define i64 @add(i64 %a, i64 %b) {
entry:
  %r = add i64 %a, %b
  ret i64 %r
}

; CHECK-LABEL: add:
; CHECK: add a0, a0, a1
; CHECK: ret
