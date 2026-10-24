`timescale 1ns/1ps
// Smart Parking Management System (8 slots)
// Parts: 1 Entry/Allocation, 2 Exit/Release, 3 Occupancy Register + Counter,
//        4 Availability/Display.  Common blocks are listed first.

// ---------------- Common building blocks ----------------

// D flip-flop, synchronous reset
module dff_r (clk, rst, d, q);
    input  clk, rst, d;
    output reg q;
    always @(posedge clk)
        if (rst) q <= 1'b0;
        else     q <= d;
endmodule

// Rising-edge detector: one pulse per button press
module edge_detect (clk, rst, sig, pulse);
    input  clk, rst, sig;
    output pulse;
    wire   sig_d;
    dff_r u_dff (clk, rst, sig, sig_d);
    and   u_and (pulse, sig, ~sig_d);
endmodule

// 3-to-8 decoder with enable
module decoder3to8 (en, in, out);
    input        en;
    input  [2:0] in;
    output [7:0] out;
    assign out[0] = en & ~in[2] & ~in[1] & ~in[0];
    assign out[1] = en & ~in[2] & ~in[1] &  in[0];
    assign out[2] = en & ~in[2] &  in[1] & ~in[0];
    assign out[3] = en & ~in[2] &  in[1] &  in[0];
    assign out[4] = en &  in[2] & ~in[1] & ~in[0];
    assign out[5] = en &  in[2] & ~in[1] &  in[0];
    assign out[6] = en &  in[2] &  in[1] & ~in[0];
    assign out[7] = en &  in[2] &  in[1] &  in[0];
endmodule

// 8-to-1 multiplexer
module mux8to1 (d, sel, y);
    input  [7:0] d;
    input  [2:0] sel;
    output reg   y;
    always @(*) begin
        case (sel)
            3'd0: y = d[0];
            3'd1: y = d[1];
            3'd2: y = d[2];
            3'd3: y = d[3];
            3'd4: y = d[4];
            3'd5: y = d[5];
            3'd6: y = d[6];
            default: y = d[7];
        endcase
    end
endmodule

// 8-to-3 priority encoder, bit 0 highest priority
module priority_encoder8 (in, code, valid);
    input  [7:0] in;
    output reg [2:0] code;
    output       valid;
    assign valid = |in;
    always @(*) begin
        casez (in)
            8'b???????1: code = 3'd0;
            8'b??????10: code = 3'd1;
            8'b?????100: code = 3'd2;
            8'b????1000: code = 3'd3;
            8'b???10000: code = 3'd4;
            8'b??100000: code = 3'd5;
            8'b?1000000: code = 3'd6;
            8'b10000000: code = 3'd7;
            default    : code = 3'd0;
        endcase
    end
endmodule


// Full adder from gates
module full_adder (a, b, cin, sum, cout);
    input  a, b, cin;
    output sum, cout;
    wire t, c1, c2;
    xor u_x1 (t, a, b);
    xor u_x2 (sum, t, cin);
    and u_a1 (c1, a, b);
    and u_a2 (c2, t, cin);
    or  u_o1 (cout, c1, c2);
endmodule

// 4-bit ripple-carry adder
module adder4 (a, b, cin, sum, cout);
    input  [3:0] a, b;
    input        cin;
    output [3:0] sum;
    output       cout;
    wire   [2:0] c;
    full_adder u_fa0 (a[0], b[0], cin,  sum[0], c[0]);
    full_adder u_fa1 (a[1], b[1], c[0], sum[1], c[1]);
    full_adder u_fa2 (a[2], b[2], c[1], sum[2], c[2]);
    full_adder u_fa3 (a[3], b[3], c[2], sum[3], cout);
endmodule

// 4-bit subtractor: diff = a - b  (a + ~b + 1); no_borrow = 1 when a >= b
module subtractor4 (a, b, diff, no_borrow);
    input  [3:0] a, b;
    output [3:0] diff;
    output       no_borrow;
    adder4 u_add (a, ~b, 1'b1, diff, no_borrow);
endmodule


// ---------------- Part 1: Entry and slot allocation ----------------
module entry_slot_allocator (entry_pulse, occupancy, alloc_slot, entry_ok, alloc_onehot);
    input        entry_pulse;
    input  [7:0] occupancy;         // 1 = occupied
    output [2:0] alloc_slot;        // slot given to the vehicle
    output       entry_ok;          // entry granted
    output [7:0] alloc_onehot;

    wire [7:0] free_slots;
    wire       free_found;

    assign free_slots = ~occupancy;

    priority_encoder8 u_pe  (free_slots, alloc_slot, free_found);
    and               u_ok  (entry_ok, entry_pulse, free_found);
    decoder3to8       u_dec (entry_ok, alloc_slot, alloc_onehot);
endmodule


// ---------------- Part 2: Exit and slot release ----------------
module exit_slot_release (exit_pulse, exit_slot, occupancy, exit_ok, release_onehot);
    input        exit_pulse;
    input  [2:0] exit_slot;         // slot being vacated
    input  [7:0] occupancy;
    output       exit_ok;           // exit accepted
    output [7:0] release_onehot;

    wire slot_is_occ;

    mux8to1     u_mux (occupancy, exit_slot, slot_is_occ);
    and         u_ok  (exit_ok, exit_pulse, slot_is_occ);
    decoder3to8 u_dec (exit_ok, exit_slot, release_onehot);
endmodule


// ---------------- Part 3: Occupancy register and counter ----------------

// 8 flip-flops, one per slot: D = set | (Q & ~clr)
module occupancy_register (clk, rst, set_vec, clr_vec, occupancy);
    input        clk, rst;
    input  [7:0] set_vec;
    input  [7:0] clr_vec;
    output [7:0] occupancy;

    wire [7:0] d;
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : slot_ff
            assign d[i] = set_vec[i] | (occupancy[i] & ~clr_vec[i]);
            dff_r u_ff (clk, rst, d[i], occupancy[i]);
        end
    endgenerate
endmodule

// 4-bit up/down counter (0..8) built on the adder.
// inc only: +1 (0001), dec only: -1 (1111, two's complement), else +0
module vehicle_counter (clk, rst, inc, dec, count);
    input        clk, rst;
    input        inc, dec;
    output [3:0] count;

    wire       inc_only, dec_only, cout_nc;
    wire [3:0] step, next;

    and u_inc (inc_only, inc, ~dec);
    and u_dec (dec_only, dec, ~inc);
    or  u_lsb (step[0], inc_only, dec_only);
    buf u_s1  (step[1], dec_only);
    buf u_s2  (step[2], dec_only);
    buf u_s3  (step[3], dec_only);

    adder4 u_add (count, step, 1'b0, next, cout_nc);

    dff_r u_ff0 (clk, rst, next[0], count[0]);
    dff_r u_ff1 (clk, rst, next[1], count[1]);
    dff_r u_ff2 (clk, rst, next[2], count[2]);
    dff_r u_ff3 (clk, rst, next[3], count[3]);
endmodule

// 4-bit ticket counter: serial number given to each admitted vehicle
module ticket_counter (clk, rst, en, ticket_next);
    input        clk, rst, en;
    output [3:0] ticket_next;       // number given to the car entering now

    wire [3:0] ticket;
    wire       cout_nc;

    adder4 u_add (ticket, {3'b000, en}, 1'b0, ticket_next, cout_nc);

    dff_r u_ff0 (clk, rst, ticket_next[0], ticket[0]);
    dff_r u_ff1 (clk, rst, ticket_next[1], ticket[1]);
    dff_r u_ff2 (clk, rst, ticket_next[2], ticket[2]);
    dff_r u_ff3 (clk, rst, ticket_next[3], ticket[3]);
endmodule

// Slot memory: 8 words x 4 bits, holds the ticket parked in each slot
// (0 = empty). Written on entry, cleared on exit, read by slot number.
module slot_memory (clk, rst, wr_en, wr_slot, wr_data, clr_en, clr_slot,
                    rd_slot, rd_data);
    input        clk, rst;
    input        wr_en;
    input  [2:0] wr_slot;
    input  [3:0] wr_data;
    input        clr_en;
    input  [2:0] clr_slot;
    input  [2:0] rd_slot;
    output [3:0] rd_data;

    reg [3:0] mem [0:7];
    integer i;

    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 8; i = i + 1) mem[i] <= 4'd0;
        end else begin
            if (clr_en) mem[clr_slot] <= 4'd0;
            if (wr_en)  mem[wr_slot]  <= wr_data;
        end
    end

    assign rd_data = mem[rd_slot];
endmodule


// ---------------- Part 4: Availability and display ----------------

// 7-segment decoder (hex), common cathode, seg = {a,b,c,d,e,f,g}
module seven_seg_decoder (digit, seg);
    input  [3:0] digit;
    output reg [6:0] seg;
    always @(*) begin
        case (digit)
            4'h0: seg = 7'b1111110;
            4'h1: seg = 7'b0110000;
            4'h2: seg = 7'b1101101;
            4'h3: seg = 7'b1111001;
            4'h4: seg = 7'b0110011;
            4'h5: seg = 7'b1011011;
            4'h6: seg = 7'b1011111;
            4'h7: seg = 7'b1110000;
            4'h8: seg = 7'b1111111;
            4'h9: seg = 7'b1111011;
            4'hA: seg = 7'b1110111;
            4'hB: seg = 7'b0011111;
            4'hC: seg = 7'b1001110;
            4'hD: seg = 7'b0111101;
            4'hE: seg = 7'b1001111;
            default: seg = 7'b1000111;
        endcase
    end
endmodule

// Displays: occupied count, free count, next slot, ticket at exit slot
// status: 00 empty, 01 available, 10 almost full (<=2 free), 11 full
module availability_display (count, alloc_slot, ticket_rd, free_count, full, empty,
                             seg_occ, seg_free, seg_slot, seg_tkt, status);
    input  [3:0] count;
    input  [2:0] alloc_slot;
    input  [3:0] ticket_rd;
    output [3:0] free_count;
    output       full, empty;
    output [6:0] seg_occ, seg_free, seg_slot, seg_tkt;
    output [1:0] status;

    wire       almost_full, no_borrow;
    wire [6:0] seg_slot_raw;

    subtractor4 u_sub (4'd8, count, free_count, no_borrow);

    assign full        = count[3];
    assign empty       = ~(|count);
    assign almost_full = (free_count == 4'd1) | (free_count == 4'd2);

    assign status[1] = full | almost_full;
    assign status[0] = full | (~empty & ~almost_full);

    seven_seg_decoder u_seg_occ  (count,            seg_occ);
    seven_seg_decoder u_seg_free (free_count,       seg_free);
    seven_seg_decoder u_seg_slot ({1'b0, alloc_slot}, seg_slot_raw);
    seven_seg_decoder u_seg_tkt  (ticket_rd,        seg_tkt);

    // show '-' on the next-slot display when the lot is full
    assign seg_slot = full ? 7'b0000001 : seg_slot_raw;
endmodule


// ---------------- Top level ----------------
module smart_parking_top (clk, rst, entry_req, exit_req, exit_slot,
                          alloc_slot, entry_ok, exit_ok, occupancy,
                          count, free_count, ticket_rd, full, empty,
                          seg_occ, seg_free, seg_slot, seg_tkt, status);
    input        clk, rst;
    input        entry_req, exit_req;
    input  [2:0] exit_slot;
    output [2:0] alloc_slot;
    output       entry_ok, exit_ok;
    output [7:0] occupancy;
    output [3:0] count, free_count, ticket_rd;
    output       full, empty;
    output [6:0] seg_occ, seg_free, seg_slot, seg_tkt;
    output [1:0] status;

    wire       entry_pulse, exit_pulse;
    wire [7:0] alloc_onehot, release_onehot;
    wire [3:0] ticket_next;

    edge_detect u_ed_in  (clk, rst, entry_req, entry_pulse);
    edge_detect u_ed_out (clk, rst, exit_req,  exit_pulse);

    entry_slot_allocator u_entry (entry_pulse, occupancy, alloc_slot,
                                  entry_ok, alloc_onehot);
    exit_slot_release    u_exit  (exit_pulse, exit_slot, occupancy,
                                  exit_ok, release_onehot);
    occupancy_register   u_occ   (clk, rst, alloc_onehot, release_onehot,
                                  occupancy);
    vehicle_counter      u_cnt   (clk, rst, entry_ok, exit_ok, count);
    ticket_counter       u_tkt   (clk, rst, entry_ok, ticket_next);
    slot_memory          u_mem   (clk, rst, entry_ok, alloc_slot, ticket_next,
                                  exit_ok, exit_slot, exit_slot, ticket_rd);
    availability_display u_disp  (count, alloc_slot, ticket_rd, free_count,
                                  full, empty, seg_occ, seg_free, seg_slot,
                                  seg_tkt, status);
endmodule
