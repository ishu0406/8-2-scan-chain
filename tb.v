
module scan_chain2_tb;

reg CLK;
reg RESET;
reg SE;
reg SI;
reg [1:0] D;

wire [1:0] Q;
wire SO;

scan_chain2 dut (
    .CLK(CLK),
    .RESET(RESET),
    .SE(SE),
    .SI(SI),
    .D(D),
    .Q(Q),
    .SO(SO)
);

always #5 CLK = ~CLK;

initial begin
    $dumpfile("scan_chain2.vcd");
    $dumpvars(0, scan_chain2_tb);

    CLK = 0;
    RESET = 1;
    SE = 0;
    SI = 0;
    D = 2'b00;

    #2;
    $display("Time=%0t | RESET=%b | SE=%b | Q=%b | SO=%b",
             $time, RESET, SE, Q, SO);

    #6;
    RESET = 0;
    D = 2'b10;
    SE = 0;

    @(posedge CLK);
    #1;
    $display("Functional: D=%b | Q=%b | SO=%b",
             D, Q, SO);

    @(negedge CLK);
    SE = 1;
    SI = 1;

    @(posedge CLK);
    #1;
    $display("Scan: SI=%b | Q=%b | SO=%b",
             SI, Q, SO);

    @(negedge CLK);
    SI = 0;

    @(posedge CLK);
    #1;
    $display("Scan: SI=%b | Q=%b | SO=%b",
             SI, Q, SO);

    $display("Simulation Finished");
    $finish;
end

endmodule
