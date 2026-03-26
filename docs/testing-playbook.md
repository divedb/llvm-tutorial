# MyRISCV 测试体系与模板

目标是建立可持续回归机制，避免后端静默错码。

## 分层测试模型

1. CodeGen 层：`.ll -> .s`
2. MC 层：`.s -> .o` 与编码校验
3. Execution 层：链接后在 `qemu-riscv64` 运行

## 目录建议

```text
test/
  CodeGen/MyRISCV/
  MC/MyRISCV/
  Execution/MyRISCV/
```

## 1) CodeGen 模板

样例：`test/CodeGen/MyRISCV/add.ll`

```llvm
; RUN: llc -march=myriscv -mattr=+rv64i < %s | FileCheck %s

define i64 @add(i64 %a, i64 %b) {
entry:
  %r = add i64 %a, %b
  ret i64 %r
}

; CHECK-LABEL: add:
; CHECK: add a0, a0, a1
; CHECK: ret
```

## 2) MC 模板

样例：`test/MC/MyRISCV/add.s`

```asm
# RUN: llvm-mc -triple=myriscv64-unknown-linux-gnu -show-encoding %s | FileCheck %s

add a0, a0, a1
# CHECK: encoding:
```

## 3) Execution 模板

样例：`test/Execution/MyRISCV/add.c`

```c
long add(long a, long b) { return a + b; }
int main() { return add(20, 22) != 42; }
```

建议执行命令（按你的工具链路径调整）：

```bash
clang --target=myriscv64-unknown-linux-gnu test/Execution/MyRISCV/add.c -o /tmp/add.riscv
qemu-riscv64 /tmp/add.riscv
echo $?
```

返回值为 `0` 即通过。

## 测试写作规则

- 每加 1 个特性，新增 3 到 5 个测试。
- 每个缺陷修复，至少补 1 个回归测试。
- 优先短小函数，避免一个用例覆盖太多语义。
- FileCheck 只检查关键信号，不做过度约束。

## 推荐最小 smoke 集

- `ret42.ll`
- `add.ll`
- `local.ll`
- `min.ll`
- `sum_loop.ll`
- `call.ll`
- `fib.ll`
- `global.ll`

## 常见失败定位手段

```bash
llc -march=myriscv -debug test.ll -o /dev/null
llc -march=myriscv -print-before-all -print-after-all test.ll -o /dev/null
llvm-objdump -d a.out
```

如遇分支、栈帧、调用约定问题，优先对照上游 RISC-V 后端同类测试。
