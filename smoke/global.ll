@g = global i64 9, align 8

define i64 @f() {
entry:
  %v = load i64, ptr @g, align 8
  ret i64 %v
}
