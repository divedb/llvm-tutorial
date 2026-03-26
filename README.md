# LLVM MyRISCV Backend 落地计划

这个仓库用于按"从 0 到可用，再到可维护、可优化"的方式，逐步实现一个可运行的 LLVM RISC-V 子集后端（代号 `MyRISCV`）。

## 目标边界（第一版）

- 仅支持 `RV64I`
- 仅支持 little-endian
- 仅支持 Linux ELF
- 不做 `PIC/TLS/F/D/C/V/A`
- 不做 `varargs/byval/sret`

## 你会得到什么

- 一份可执行里程碑路线图（含验收命令）
- 一套最小测试分层模板（.ll -> .s -> .o -> 运行）
- 第一周可直接开工的任务单

## 文档索引

- 里程碑与验收标准：`docs/myriscv-roadmap.md`
- 测试体系与模板：`docs/testing-playbook.md`
- 第一周任务单：`plans/week1.md`

## 快速执行流程

1. 先完成 Milestone 0（target 被 `llc` 识别）。
2. 每完成一个特性，至少补 3 个测试（代码生成、MC/编码、执行结果）。
3. 所有里程碑都执行三段式验收：
	- `llc` 生成汇编
	- 组装/链接成功
	- 在 `qemu-riscv64` 上运行结果正确

## 建议工具链

- `llc`
- `llvm-mc`
- `llvm-objdump`
- `FileCheck`
- `qemu-riscv64`

## 约定

- 后端名字统一使用 `MyRISCV`
- 目标架构名称统一使用 `myriscv`
- 优先 SelectionDAG，暂不引入 GlobalISel

