// Testbench for smart_parking_top
// Compile: iverilog -o sim smart_parking.v tb_smart_parking.v && vvp sim
`timescale 1ns/1ps
module tb_smart_parking;
    reg        clk, rst, entry_req, exit_req;
    reg  [2:0] exit_slot;
    wire [2:0] alloc_slot;
    wire       entry_ok, exit_ok, full, empty;
    wire [7:0] occupancy;
    wire [3:0] count, free_count, ticket_rd;
    wire [6:0] seg_occ, seg_free, seg_slot, seg_tkt;
    wire [1:0] status;

    smart_parking_top dut (clk, rst, entry_req, exit_req, exit_slot,
                           alloc_slot, entry_ok, exit_ok, occupancy,
                           count, free_count, ticket_rd, full, empty,
                           seg_occ, seg_free, seg_slot, seg_tkt, status);

    always #5 clk = ~clk;

    // remember the slot that was actually granted
    reg [2:0] last_slot;
    always @(posedge clk) if (entry_ok) last_slot <= alloc_slot;

    task car_in;
        begin
            @(negedge clk) entry_req = 1;
            @(negedge clk) entry_req = 0;
            @(negedge clk);
            $display("%0t ENTRY slot=%0d occ=%b cnt=%0d free=%0d full=%b status=%b | seg occ=%b free=%b next=%b",
                     $time, last_slot, occupancy, count, free_count, full, status,
                     seg_occ, seg_free, seg_slot);
        end
    endtask

    task car_out(input [2:0] s);
        begin
            @(negedge clk) begin exit_slot = s; exit_req = 1; end
            #1 tk = ticket_rd;      // ticket held in the slot before it is cleared
            @(negedge clk) exit_req = 0;
            @(negedge clk);
            $display("%0t EXIT  slot=%0d ticket=%0d occ=%b cnt=%0d free=%0d empty=%b status=%b | seg occ=%b free=%b tkt=%b",
                     $time, s, tk, occupancy, count, free_count, empty, status,
                     seg_occ, seg_free, seg_tkt);
        end
    endtask

    reg [3:0] tk;
    integer k;
    initial begin
        clk = 0; rst = 1; entry_req = 0; exit_req = 0; exit_slot = 0;
        repeat (3) @(negedge clk);
        rst = 0;

        $display("--- fill the lot ---");
        for (k = 0; k < 8; k = k + 1) car_in;

        $display("--- 9th car while full (rejected) ---");
        car_in;

        $display("--- slots 3 and 5 leave ---");
        car_out(3'd3);
        car_out(3'd5);

        $display("--- exit from free slot 5 (ignored) ---");
        car_out(3'd5);

        $display("--- new cars reuse slots 3 then 5 ---");
        car_in;
        car_in;

        $display("--- empty the lot ---");
        for (k = 0; k < 8; k = k + 1) car_out(k[2:0]);

        $display("--- exit when empty (ignored) ---");
        car_out(3'd0);

        $finish;
    end
endmodule
