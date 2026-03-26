# Week 1 任务单（可直接执行）

本周目标：完成 Milestone 0，并尽量进入 Milestone 1（寄存器和最小指令描述）。

## Day 1: 建骨架与 CMake 接入

### 任务

- 新建 `llvm/lib/Target/MyRISCV/` 基础目录
- 新建 `TargetInfo/` 与 `MCTargetDesc/` 子目录
- 接入 LLVM 构建系统

### 验收

- LLVM 全量或最小目标构建通过
- 无缺失符号

## Day 2: Target 注册打通

### 任务

- 实现并注册：
  - `LLVMInitializeMyRISCVTarget`
  - `LLVMInitializeMyRISCVTargetMC`
  - `LLVMInitializeMyRISCVAsmPrinter`
- 实现最小 `TargetMachine`

### 验收

```bash
llc -march=myriscv --version
```

输出中应能看到 `myriscv`。

## Day 3: TableGen 最小寄存器定义

### 任务

- 定义 GPR 与 `GPR64`
- 处理基本编号、别名、最小保留寄存器

### 验收

- TableGen 生成通过
- 后端可编译

## Day 4: 最小指令定义

### 任务

- 增加 `ADD/SUB/ADDI/LD/SD/JALR/RET(pseudo)`
- 打通最小 `InstrInfo` 与 `RegisterInfo` 桩实现

### 验收

```bash
llc -march=myriscv smoke/ret42.ll -o -
```

至少不再因为指令/寄存器缺失直接失败。

## Day 5: 周回归 + 问题清单

### 任务

- 整理本周失败点（调用约定、帧索引、伪指令、编码）
- 把失败点转换为下周具体任务
- 补 3 个 smoke 测试文件模板

### 验收

- 可复现问题清单（每条含重现命令）
- 下周任务按优先级排序

## 本周 DoD（Definition of Done）

满足以下全部条件即视为本周完成：

1. `llc -march=myriscv` 不再 unknown target。
2. 后端可成功编译并注册。
3. 至少 1 个 `.ll` 能走到 MyRISCV 路径并产出可读输出。
4. 建立基础测试目录与至少 3 个模板测试。

## 风险与回避

- 风险：试图一次做完整 ABI。
  - 回避：本周只做 target 识别和最小寄存器/指令。
- 风险：无测试导致回归不可控。
  - 回避：当天改动当天补 smoke 测试。
