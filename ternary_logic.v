module my_not(in, out);
  input wire in;
  output wire out;

  supply1 vdd; 
  supply0 gnd; 

  pmos pmos1(out, vdd, in); 
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

module my_and(in1, in2, out);
  input wire in1;
  input wire in2;
  output wire out;

  wire nand_out;

  nand_gate nand_gate1(in1, in2, nand_out);
  my_not not_gate1(nand_out, out);
endmodule

module my_or(in1, in2, out);
  input wire in1;
  input wire in2;
  output wire out;

  wire nor_out;

  nor_gate nor_gate1(in1, in2, nor_out);
  my_not not_gate1(nor_out, out);
endmodule

module ternary_min(a[1:0], b[1:0], out[1:0]);
  input [1:0] a;
  input [1:0] b;
  output [1:0] out;
  
  wire o1;
  wire o2;
  wire o3;
  wire o4;
  wire o5;
  wire a1;
  wire a2;
  wire a3;
  wire a4;
  wire n1;
  wire n2;    
  wire n3;
  wire n4;
  wire a5;
  wire a6;
  
  my_not not1(a[0],n1);
  my_not not2(a[1],n2);
  my_not not3(b[0],n3);
  my_not not4(b[1],n4);
  
  my_or or1(a[1],a[0],o1);
  my_or or2(a[0],b[0],o2);
  my_or or3(b[1],b[0],o3);
  my_or or4(n1,n2,o4);
  my_or or5(n3,n4,o5);
  my_and and1(o1,o2,a1);
  my_and and2(a1,o3,a2);
  my_and and3(a2,o4,a3);
  my_and and4(a3,o5,out[0]);
    
  my_and and5(a[1],n1,a5);
  my_and and6(b[1],a5,a6);
  my_and and7(a6,n3,out[1]);
endmodule

module ternary_max(a[1:0], b[1:0], out[1:0]);
  input [1:0] a;
  input [1:0] b;
  output [1:0] out;
  
  wire n1;
  wire n2;
  wire o1;
  wire a1;
  wire a2;
  
  my_not not1(a[1],n1);
  my_not not2(b[1],n2);
  
  my_or or1(a[0],b[0],o1);
  my_and and1(n1,n2,a1);
  my_and and2(a1,o1,out[0]);
  
  my_or or2(a[1],b[1],out[1]);
endmodule

module ternary_consensus(a[1:0], b[1:0], out[1:0]);
  input [1:0] a;
  input [1:0] b;
  output [1:0] out;
  
  wire n1;
  wire n2;
  wire a1;
  wire a2;
  wire a3;
  wire n3;
  wire n4;
  wire a4;
  wire a5;
  wire o1;
  wire o2;
  wire o3;
  
  my_not not1(a[0],n1);
  my_not not2(b[0],n2);
  my_not not3(b[1],n3);
  my_not not4(a[1],n4);
  
  my_and and1(a[1],n1,a1);
  my_and and2(a1,b[1],a2);
  my_and and3(a2,n2,out[1]);
  
  my_or or1(a[0],b[0],o1);
  my_and and4(a[1],n3,a4);
  my_and and5(b[1],n4,a5);
  my_or or2(o1,a4,o2);
  my_or or3(o2,a5,out[0]);
endmodule

module ternary_any(a[1:0], b[1:0], out[1:0]);
  input [1:0] a;
  input [1:0] b;
  output [1:0] out;
  
  wire o1;
  wire o2;
  wire o3;
  wire o4;
  wire o5;
  wire a1;
  wire a2;
  wire a3;
  wire a4;
  wire n1;
  wire n2;
  wire n3;
  wire n4;
  wire o6;
  wire o7;
  wire o8;
  wire o9;
  wire o10;
  wire o11;
  wire a5;
  wire a6;
  wire a7;
  wire a8;

  my_not not1(a[1],n1);
  my_not not2(a[0],n2);
  my_not not3(b[1],n3);
  my_not not4(b[0],n4);
  
  my_or or1(a[1],a[0],o1);
  my_or or2(a[1],b[1],o2);
  my_or or3(b[1],b[0],o3);
  my_or or4(n1,n2,o4);
  my_or or5(n3,n4,o5);
  my_and and1(o1,o2,a1);
  my_and and2(a1,o3,a2);
  my_and and3(a2,o4,a3);
  my_and and4(a3,o5,out[1]);
    
  my_or or6(a[0],n4,o6);
  my_or or7(n1,n2,o7);
  my_or or8(n1,n3,o8);
  my_or or9(n2,n3,o9);
  my_or or10(a[1],b[1],or10);
  my_or or11(or10,b[0],o11);
  my_and and5(or6,o7,a5);
  my_and and6(a5,o8,a6);
  my_and and7(a6,o9,a7);
  my_and and8(a7,o11,out[0]);
endmodule