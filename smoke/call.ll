declare i64 @g(i64)

define i64 @f(i64 %y) {
entry:
  %r = call i64 @g(i64 %y)
  ret i64 %r
}

define i64 @g(i64 %x) {
entry:
  %r = add i64 %x, 1
  ret i64 %r
}
