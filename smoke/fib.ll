define i64 @fib(i64 %n) {
entry:
  %base = icmp slt i64 %n, 2
  br i1 %base, label %ret, label %recur

ret:
  ret i64 %n

recur:
  %n1 = sub i64 %n, 1
  %n2 = sub i64 %n, 2
  %f1 = call i64 @fib(i64 %n1)
  %f2 = call i64 @fib(i64 %n2)
  %sum = add i64 %f1, %f2
  ret i64 %sum
}
