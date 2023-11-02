module not_gate(in, out);
  input wire in;
  output wire out;

  supply1 vdd; // Напряжение питания
  supply0 gnd; // Напряжение земли

  pmos pmos1(out, vdd, in); // (сток, исток, база)
  nmos nmos1(out, gnd, in);
endmodule

module nand_gate(in1, in2, out);
  input wire in1;
  input wire in2;
  output wire out;

  supply0 gnd;
  supply1 pwr;

  wire nmos1_out;

  pmos pmos1(out, pwr, in1);
  pmos pmos2(out, pwr, in2);
  nmos nmos1(nmos1_out, gnd, in1);
  nmos nmos2(out, nmos1_out, in2);
endmodule


module nor_gate(in1, in2, out);
  input wire in1;
  input wire in2;
  output wire out;

  supply0 gnd;
  supply1 pwr;

  wire pmos1_out;

  pmos pmos1(pmos1_out, pwr, in1);
  pmos pmos2(out, pmos1_out, in2);
  nmos nmos1(out, gnd, in1);
  nmos nmos2(out, gnd, in2);
endmodule


module and_gate(in1, in2, out);
  input wire in1;
  input wire in2;
  output wire out;

  wire nand_out;

  nand_gate nand_gate1(in1, in2, nand_out);
  not_gate not_gate1(nand_out, out);
endmodule

module or_gate(in1, in2, out);
  input wire in1;
  input wire in2;
  output wire out;

  wire nor_out;

  nor_gate nor_gate1(in1, in2, nor_out);
  not_gate not_gate1(nor_out, out);
endmodule

module xor_gate(in1, in2, out);
  input wire in1;
  input wire in2;
  output wire out;

  wire not_in1;
  wire not_in2;

  wire and_out1;
  wire and_out2;

  wire or_out1;


  not_gate not_gate1(in1, not_in1);
  not_gate not_gate2(in2, not_in2);

  and_gate and_gate1(in1, not_in2, and_out1);
  and_gate and_gate2(not_in1, in2, and_out2);

  or_gate or_gate1(and_out1, and_out2, out);
endmodule

module half_adder(a, b, c_out, s);
  input wire a;
  input wire b;
  output wire c_out;
  output wire s;

  and_gate and_gate1(a, b, c_out);

  xor_gate xor_gate1(a, b, s);
endmodule

module summa(in1, in2, in3, out);
    input wire in1;
    input wire in2;
    input wire in3;
    output wire out;
    
    wire n1;
    wire n2;
    wire n3;
    
    wire a1;
    wire a2;
    wire a3;
    wire a4;
    wire a5;
    wire a6;
    wire a7;
    wire a8;
    
    wire o1;
    wire o2;
    
    not_gate nn1(in1, n1);
    not_gate nn2(in2, n2);
    not_gate nn3(in3, n3);
    
    and_gate aa1(n1,n2,a1);
    and_gate aa2(a1,in3,a2);
    
    and_gate aa3(n1,in2, a3);
    and_gate aa4(a3, n3, a4);
    
    and_gate aa5(in1, n2, a5);
    and_gate aa6(a5, n3, a6);
    
    and_gate aa7(in1, in2, a7);
    and_gate aa8(a7, in3, a8);
    
    or_gate oo1(a2, a4, o1);
    or_gate oo2(o1, a6, o2);
    or_gate oo3(o2, a8, out);
endmodule

module perenos(in1, in2, in3, out);
    input wire in1;
    input wire in2;
    input wire in3;
    output wire out;
    
    wire n1;
    wire n2;
    wire n3;
    
    wire a1;
    wire a2;
    wire a3;
    wire a4;
    wire a5;
    wire a6;
    wire a7;
    wire a8;
    
    wire o1;
    wire o2;
    
    not_gate nn1(in1, n1);
    not_gate nn2(in2, n2);
    not_gate nn3(in3, n3);
    
    and_gate aa1(n1,in2,a1);
    and_gate aa2(a1,in3, a2);
    
    and_gate aa3(in1,n2, a3);
    and_gate aa4(a3, in3, a4);
    
    and_gate aa5(in1, in2, a5);
    and_gate aa6(a5, n3, a6);
    
    and_gate aa7(in1, in2, a7);
    and_gate aa8(a7, in3, a8);
    
    or_gate oo1(a2, a4, o1);
    or_gate oo2(o1, a6, o2);
    or_gate oo3(o2, a8, out);
endmodule

module adder(in1, in2, c2, out);
    input [3:0] in1;
    input [3:0] in2;
    input wire c2;
    output [3:0] out;
    
    wire w1;
    wire w2;
    wire w3;
    
    summa s1(in1[0], in2[0], c2, out[0]);
    perenos p1(in1[0], in2[0], c2, w1);
    summa s2(in1[1], in2[1], w1, out[1]);
    perenos p2(in1[1], in2[1], w1, w2);
    summa s3(in1[2], in2[2], w2, out[2]);
    perenos p3(in1[2], in2[2], w2, w3);
    summa s4(in1[3], in2[3], w3, out[3]);
endmodule

module four_and(in1, in2, out);
    input [3:0] in1;
    input [3:0] in2;
    output [3:0] out;
    
    and_gate a0(in1[0], in2[0], out[0]);
    and_gate a1(in1[1], in2[1], out[1]);
    and_gate a2(in1[2], in2[2], out[2]);
    and_gate a3(in1[3], in2[3], out[3]);
endmodule

module four_or(in1, in2, out);
    input [3:0] in1;
    input [3:0] in2;
    output [3:0] out;
    
    or_gate a0(in1[0], in2[0], out[0]);
    or_gate a1(in1[1], in2[1], out[1]);
    or_gate a2(in1[2], in2[2], out[2]);
    or_gate a3(in1[3], in2[3], out[3]);
endmodule

module spec_and(in1, in2, out);
    input [3:0] in1;
    input wire in2;
    output [3:0] out;
    
    and_gate a0(in1[0], in2, out[0]);
    and_gate a1(in1[1], in2, out[1]);
    and_gate a2(in1[2], in2, out[2]);
    and_gate a3(in1[3], in2, out[3]);
endmodule

module slt(in1, in2, c2, out);
    input wire [3:0] in1;
    input wire [3:0] in2;
    input wire c2;
    output wire [3:0] out;
    
    wire n1;
    wire n2;
    
    wire [3:0] s1;
    wire [3:0] s2;
    
    wire a1;
    wire o1;
    wire o2;
    wire a2;
    
    not_gate nn1(in2[3], n1);
    
    adder ss1(in1, in2, c2, s1);
    
    and_gate aa1(in1[3], n1, a1);
    or_gate oo1(a1, s1[3], o1);
    or_gate oo2(in1[3], n1, o2);
    and_gate aa2(o2, o1, a2);
    adder ss2(4'b0000, 4'b0000, a2, out);
    not_gate nn2(out[0], n2);
    assign out[0] = n2;
    
endmodule

module multiplex_2_to_1(in1, con, out);
    input wire in1;
    input wire con;
    
    output wire out;
    
    wire n1;
    wire n2;
    wire a1;
    wire a2;
    
    not_gate ng1(in1, n1);
    not_gate ng2(con, n2);
    and_gate an1(con, n1, a1);
    and_gate an2(n2, in1, a2);
    or_gate or1(a1, a2, out);
endmodule

module multiplex_4_to_1(in1, in2, in3, in4, c1, c0, out);
    input [3:0] in1;
    input [3:0] in2;
    input [3:0] in3;
    input [3:0] in4;
    input wire c1;
    input wire c0;
    output [3:0] out;
    
    wire n0;
    wire n1;
    
    wire prom0;
    wire prom1;
    wire prom2;
    wire prom3;
    
    wire [3:0] p0;
    wire [3:0] p1;
    wire [3:0] p2;
    wire [3:0] p3;
    
    wire [3:0] q1;
    wire [3:0] q2;
    
    not_gate no0(c1, n1);
    not_gate no1(c0, n0);
    
    nor_gate nor1(c1, c0, prom0);
    and_gate a1(n1, c0, prom1);
    and_gate a2(c1, c0, prom3);
    and_gate a3(c1, n0, prom2);
    
    spec_and s0(in1, prom0, p0);
    spec_and s1(in2, prom1, p1);
    spec_and s2(in3, prom2, p2);
    spec_and s3(in4, prom3, p3);
    
    four_or f0(p0, p1, q1);
    four_or f1(q1, p2, q2);
    four_or f2(q2, p3, out);
endmodule

module alu(a, b, control, res);
  input [3:0] a, b; // Операнды
  input [2:0] control; // Управляющие сигналы для выбора операции

  output [3:0] res; 
  
  wire [3:0] mb;
  wire [3:0] n2;
  wire [3:0] n1;
  wire [3:0] n0;
  wire [3:0] n3;
  
  multiplex_2_to_1 m0(b[0], control[2], mb[0]);
  multiplex_2_to_1 m1(b[1], control[2], mb[1]);
  multiplex_2_to_1 m2(b[2], control[2], mb[2]);
  multiplex_2_to_1 m3(b[3], control[2], mb[3]);
  
  adder a1(a, mb, control[2], n2);
  
  four_and a0(a, mb, n0);
  
  four_or o0(a, mb, n1);
  
  slt s0(a, mb, control[2], n3);
  
  multiplex_4_to_1 mm(n0, n1, n2, n3, control[1], control[0], res);
endmodule

module d_latch(clk, d, we, q);
  input clk; // Сигнал синхронизации
  input d; // Бит для записи в ячейку
  input we; // Необходимо ли перезаписать содержимое ячейки

  output reg q; // Сама ячейка
  initial begin
    q <= 0;
  end
  always @ (negedge clk) begin
    if (we) begin
      q <= d;
    end
  end
endmodule

module register (in1, clk, we, out);
    input [3:0] in1;
    input wire clk;
    input wire we;
    output [3:0] out;
    
    d_latch d0(clk, in1[0], we, out[0]);
    d_latch d1(clk, in1[1], we, out[1]);
    d_latch d2(clk, in1[2], we, out[2]);
    d_latch d3(clk, in1[3], we, out[3]);
endmodule

module choice(in1, out);
    input [1:0] in1;
    output [3:0] out;
    
    wire n1;
    wire n0;
    
    not_gate no0(in1[1], n1);
    not_gate no1(in1[0], n0);
    
    nor_gate nor1(in1[0], in1[1], out[0]);
    and_gate a1(n1, in1[0], out[1]);
    and_gate a3(in1[1], n0, out[2]);
    and_gate a2(in1[0], in1[1], out[3]);
endmodule

module register_file(clk, rd_addr, we_addr, we_data, rd_data);
  input clk; // Сигнал синхронизации
  input [1:0] rd_addr, we_addr; // Номера регистров для чтения и записи
  input [3:0] we_data; // Данные для записи в регистровый файл

  output [3:0] rd_data; // Данные, полученные в результате чтения из регистрового файла
  
  wire [3:0] wa;
  wire [3:0] t1;
  wire [3:0] t2;
  wire [3:0] t3;
  wire [3:0] t4;
  wire [3:0] ra;
  
  wire [3:0] t5;
  wire [3:0] t6;
  wire [3:0] t7;
  wire [3:0] t8;
  
  wire [3:0] q1;
  wire [3:0] q2;
  
  choice c1(we_addr, wa);
  choice c2(rd_addr, ra);
  
  register r1 (we_data, clk, wa[0], t1);
  register r2 (we_data, clk, wa[1], t2);
  register r3 (we_data, clk, wa[2], t3);
  register r4 (we_data, clk, wa[3], t4);
  
  spec_and a1 (t1, ra[0], t5);
  spec_and a2 (t2, ra[1], t6);
  spec_and a3 (t3, ra[2], t7);
  spec_and a4 (t4, ra[3], t8);
  
  four_or o1 (t5, t6, q1);
  four_or o2 (q1, t7, q2);
  four_or o3 (q2, t8, rd_data);
endmodule

module calculator(clk, rd_addr, immediate, we_addr, control, rd_data);
  input clk;
  input [1:0] rd_addr; 
  input [3:0] immediate; 
  input [1:0] we_addr;
  input [2:0] control;

  output [3:0] rd_data;
  
  wire [3:0] q1;
  
  alu al(rd_data, immediate, control, q1);
  register_file r_f(clk, rd_addr, we_addr, q1, rd_data);
endmodule
