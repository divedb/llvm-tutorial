# RUN: llvm-mc -triple=myriscv64-unknown-linux-gnu -show-encoding %s | FileCheck %s

add a0, a0, a1
# CHECK: add a0, a0, a1
# CHECK: encoding:
