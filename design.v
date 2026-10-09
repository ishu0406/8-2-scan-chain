
module scan_chain2(
    input CLK,
    input RESET,
    input SE,
    input SI,
    input [1:0] D,
    output reg [1:0] Q,
    output SO
);

assign SO = Q[1];

always @(posedge CLK or posedge RESET)
begin
    if (RESET)
        Q <= 2'b00;
    else if (SE)
        Q <= {Q[0], SI};
    else
        Q <= D;
end

endmodule
