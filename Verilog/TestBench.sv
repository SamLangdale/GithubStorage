
 `timescale 1ns/1ps
module seven_segments_decoder_tb;
	logic [3:0] digit;
	logic [6:0] segments;

	seven_segments_decoder dut (
		.digit(digit),
		.segments(segments)
	);
	
	initial begin
		$dumpfile("seven_segments_decoder.vcd");
		$dumpvars(0, seven_segments_decoder_tb);

		$display("Time | Digit | Segments");
 		$display("-----------------------");

		for (int i = 0; i < 10; i++) begin
			digit = i;
			#10;
			$display("%0dns |  %0d  | %b", $time, digit, segments);
		end

		digit = 4'b1010;
		#10
		$display("%0dns |  %0d  | %b", $time, digit, segments);
		$stop;
	end
endmodule
 