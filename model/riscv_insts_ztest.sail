/***************************************
 * Ztest扩展指令定义 [基于Zicond扩展模式 [^1]]
 ***************************************/

// 定义指令编码空间（需确保opcode唯一）[^5]
mapping clause encdec_ztest = 
  TEST_ADD <-> (0b0000000, 0b100, 0b0001011),
  TEST_SUB <-> (0b0100000, 0b100, 0b0001011),
  TEST_GET <-> (0b0000000, 0b000, 0b0001011)

// 定义AST解码结构
clause ast = TEST_ADD(rd, rs1, rs2) <-> Enc_ztest(rs2, rs1, rd, TEST_ADD)
clause ast = TEST_SUB(rd, rs1, rs2) <-> Enc_ztest(rs2, rs1, rd, TEST_SUB)
clause ast = TEST_GET(rd)           <-> Enc_ztest(0, 0, rd, TEST_GET)

// 自定义计数器声明（需全局唯一名称）
var zt_counter : xlenbits = 0

// 指令功能实现
clause execute(TEST_ADD(rd, rs1, rs2)) = {
  let rs1_val = X(rs1);
  let rs2_val = X(rs2);
  X(rd) = rs1_val + rs2_val;
  zt_counter = zt_counter + X(rd);
}

clause execute(TEST_SUB(rd, rs1, rs2)) = {
  let rs1_val = X(rs1);
  let rs2_val = X(rs2);
  X(rd) = rs1_val - rs2_val;
  zt_counter = zt_counter + X(rd);
}

clause execute(TEST_GET(rd)) = {
  X(rd) = zt_counter; 
}
