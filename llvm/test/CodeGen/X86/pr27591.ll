; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -o - -O0 < %s | FileCheck %s
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @test1(i32 %x) #0 {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    cmpl $0, %edi
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    movzbl %al, %eax
; CHECK-NEXT:    andl $1, %eax
; CHECK-NEXT:    movl %eax, %edi
; CHECK-NEXT:    callq callee1
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    retq
entry:
  %tobool = icmp ne i32 %x, 0
  call void @callee1(i1 zeroext %tobool)
  ret void
}

define void @test2(i32 %x) #0 {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    cmpl $0, %edi
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    movzbl %al, %eax
; CHECK-NEXT:    andl $1, %eax
; CHECK-NEXT:    negl %eax
; CHECK-NEXT:    movl %eax, %edi
; CHECK-NEXT:    callq callee2
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    retq
entry:
  %tobool = icmp ne i32 %x, 0
  call void @callee2(i1 signext %tobool)
  ret void
}

declare void @callee1(i1 zeroext)
declare void @callee2(i1 signext)

attributes #0 = { nounwind "target-cpu"="skylake-avx512" }
