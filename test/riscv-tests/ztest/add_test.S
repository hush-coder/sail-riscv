#include "riscv_test.h"

RV_TEST_CODE_BEGIN
  // 前置条件设置
  TEST_CASE_START(1)
  li x1, 0x5A5A
  li x2, 0xA5A5

  // 指令执行
  test.add x3, x1, x2    // 核心测试逻辑
  TEST_CASE_END(1)

  // 结果验证
  RV_ASSERT_EQ(x3, 0xFFFF)
RV_TEST_CODE_END

// 生成RVFI追踪数据（参考rv32ui格式 [^6]）
.data
RV_TEST_SIG_DATA()  // 自动生成签名校验段