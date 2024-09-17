module seq_multiplier ( 
    input logic [15:0] M,
    input logic [15:0] Q,
    input logic clk,
    input logic reset,
    input logic enable,
    output logic [31:0] acc 
);

    integer i;

always @(posedge clk) begin
    if (reset) begin // resets Accumulation to 0
        acc[i] <= 32'd00000000000000000000000000000000;
end
    if (enable) begin
        for (i=0; i<16; i = i+1) begin
            acc[i] <= M[i]* Q[i];
        end

    end

    end


endmodule