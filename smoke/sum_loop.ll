define i64 @sum(i64 %n) {
entry:
  br label %loop

loop:
  %n.phi = phi i64 [ %n, %entry ], [ %n.next, %body ]
  %s.phi = phi i64 [ 0, %entry ], [ %s.next, %body ]
  %cond = icmp eq i64 %n.phi, 0
  br i1 %cond, label %exit, label %body

body:
  %s.next = add i64 %s.phi, %n.phi
  %n.next = sub i64 %n.phi, 1
  br label %loop

exit:
  ret i64 %s.phi
}
