define i64 @min(i64 %a, i64 %b) {
entry:
  %cmp = icmp slt i64 %a, %b
  %res = select i1 %cmp, i64 %a, i64 %b
  ret i64 %res
}
