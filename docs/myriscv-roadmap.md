# MyRISCV 后端里程碑路线图（可执行版）

本文档把后端开发拆成可交付里程碑。每个里程碑都包含：目标、任务、验收命令、通过标准。

## 通用验收闭环（所有里程碑都执行）

1. `llc` 能跑通并生成 `.s`
2. 汇编可组装并链接
3. 产物在 `qemu-riscv64` 下执行结果正确

建议固定一个 smoke 程序目录，持续回归。

## 环境约定

- 架构：`myriscv`
- 代码生成器：SelectionDAG
- 第一版功能边界：仅 RV64I + Linux ELF + little-endian

## Milestone 0: 骨架与注册

### 目标

让 LLVM 识别 `myriscv`，`llc -march=myriscv` 不再报 unknown target。

### 任务

- 创建目录骨架：`llvm/lib/Target/MyRISCV/`
- 注册 `TargetInfo`
- 注册 `TargetMachine`
- 初始化入口：
  - `LLVMInitializeMyRISCVTarget`
  - `LLVMInitializeMyRISCVTargetMC`
  - `LLVMInitializeMyRISCVAsmPrinter`
- 接入 CMake

### 验收命令

```bash
llc -march=myriscv smoke/ret42.ll -o -
```

### 通过标准

- 没有 `unknown target`
- 能进入 MyRISCV 后端流程（即使暂时只输出最小桩汇编）

## Milestone 1: 寄存器与最小指令描述

### 目标

在 TableGen 中建立 GPR、寄存器类和最小 RV64I 指令描述。

### 任务

- 定义 GPR: `x0, ra, sp, gp, tp, t0-t6, s0-s11, a0-a7`
- 定义寄存器类：`GPR64`
- 第一批指令：`ADD SUB ADDI LD SD BEQ JAL JALR LUI AUIPC`
- 实现最小 `RegisterInfo` / `InstrInfo`

### 验收命令

```bash
llc -march=myriscv -mattr=+rv64i smoke/add.ll -o -
```

### 通过标准

- 能看到目标指令名称出现在 MachineInstr 或汇编输出中
- TableGen 生成文件可编译通过

## Milestone 2: 返回值路径（LowerReturn）

### 目标

支持 `return constant`，建立最小 AsmPrinter 路径。

### 任务

- `LowerReturn`
- `RET` 伪指令
- 最小 `AsmPrinter`

### 验收命令

```bash
llc -march=myriscv smoke/ret42.ll -o smoke/ret42.s
llvm-mc -triple=myriscv64-unknown-linux-gnu smoke/ret42.s -filetype=obj -o smoke/ret42.o
```

### 通过标准

- 汇编中含合法函数出口
- `.s` 可被 `llvm-mc` 接受

## Milestone 3: 参数与整数算术

### 目标

支持整数入参与 `add/sub`。

### 任务

- `LowerFormalArguments`
- `a0/a1` 参数传递
- `a0` 返回值
- `add/sub` pattern

### 验收命令

```bash
llc -march=myriscv smoke/add.ll -o smoke/add.s
```

### 通过标准

- `long add(long a, long b)` 生成可读且符合 ABI 预期的汇编

## Milestone 4: 栈帧与局部变量

### 目标

支持局部变量、spill/reload 的最小可用路径。

### 任务

- `emitPrologue/emitEpilogue`
- `eliminateFrameIndex`
- `storeRegToStackSlot/loadRegFromStackSlot`

### 验收命令

```bash
llc -march=myriscv smoke/local.ll -o smoke/local.s
```

### 通过标准

- 能正确处理局部变量
- 栈指针调整与恢复正确

## Milestone 5: 分支与循环

### 目标

支持 if/while。

### 任务

- `SETCC` / `BR_CC` lowering
- `analyzeBranch/insertBranch/removeBranch`

### 验收命令

```bash
llc -march=myriscv smoke/min.ll -o smoke/min.s
llc -march=myriscv smoke/sum_loop.ll -o smoke/sum_loop.s
```

### 通过标准

- 条件跳转正确
- 循环可稳定生成

## Milestone 6: 函数调用

### 目标

支持 call 与返回。

### 任务

- `LowerCall`
- call sequence
- caller/callee 保存规则

### 验收命令

```bash
llc -march=myriscv smoke/call.ll -o smoke/call.s
```

### 通过标准

- 跨函数调用结果正确

## Milestone 7: 全局地址与重定位基础

### 目标

支持全局变量访问。

### 任务

- `GlobalAddress` lowering
- `lui+addi` 或 `auipc+addi` 地址构造路径
- fixup/relo 基础联调

### 验收命令

```bash
llc -march=myriscv smoke/global.ll -o smoke/global.s
```

### 通过标准

- 全局变量加载/存储正确

## Milestone 8: MC 与对象文件

### 目标

从仅出 `.s` 升级为稳定出 `.o`。

### 任务

- `MCCodeEmitter`
- `AsmBackend`
- ELF object writer

### 验收命令

```bash
llc -march=myriscv smoke/add.ll -filetype=obj -o smoke/add.o
llvm-objdump -d smoke/add.o
```

### 通过标准

- `.o` 可被反汇编
- 指令编码与预期一致

## Milestone 9: M 扩展

### 目标

支持 `mul/div/rem`。

### 任务

- M 扩展指令描述
- legalize 与 pattern/custom select

### 验收命令

```bash
llc -march=myriscv -mattr=+m smoke/mul.ll -o smoke/mul.s
```

### 通过标准

- 基本整数乘除程序可运行

## Milestone 10: ABI 补齐与边界场景

### 目标

提升“能跑样例”到“能编更多真实 C 程序”。

### 任务

- i8/i16/i32/i64 扩展规则
- 大立即数
- 大偏移
- 更多返回/参数组合

### 验收命令

```bash
llc -march=myriscv regression/*.ll -o /dev/null
```

### 通过标准

- 回归集中大部分样例稳定通过

## 每周工作节奏建议

- 周一到周四：功能开发 + 新增测试
- 周五：回归、补边界、整理 issue
- 任何新增特性，最少附带 3 个测试：正例、边界例、回归例
