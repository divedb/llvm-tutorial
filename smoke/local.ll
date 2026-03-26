define i64 @f(i64 %a) {
entry:
  %x = alloca i64, align 8
  %t0 = add i64 %a, 1
  store i64 %t0, ptr %x, align 8
  %t1 = load i64, ptr %x, align 8
  ret i64 %t1
}
