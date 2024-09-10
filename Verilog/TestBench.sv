`timescale 1ns/1ps
module `include "test.v"
`default_nettype none

module tb_test;
    logic [3:0] digit;
    logic [6:0] segments;

test 
(
    .digit(digit),
    .segments(segments)
    
);

initial begin
    $dumpfile("tb_test.vcd");
    $dumpvars(0, tb_test);

    $display("time | digit | segments");
    $display("-----------------------");
    for (int i= 0; i < 10;i++) begin
        digit = i;
        #10
        $display("%0dns |  %0d | %b",$time,digit,segments);
        end
        
        digit = 4'b1010; // invalid input
        #10
        $display("%0dns |  %0d | %b",$time,digit,segments);
        $stop;       
end
endmodule
`default_nettype wire
