# Smart Parking Management System (Verilog HDL) - Notes

Files: `smart_parking.v` (design), `tb_smart_parking.v` (testbench)
Run: `iverilog -o sim smart_parking.v tb_smart_parking.v && vvp sim`

## 1. Ports (top: `smart_parking_top`)

| Port | Dir | Width | Meaning |
|---|---|---|---|
| clk | in | 1 | Clock |
| rst | in | 1 | Synchronous reset, active high |
| entry_req | in | 1 | Entry button / sensor |
| exit_req | in | 1 | Exit button / sensor |
| exit_slot | in | 3 | Slot number the leaving car occupies |
| alloc_slot | out | 3 | Next slot to be allocated (lowest free) |
| entry_ok / exit_ok | out | 1 | Entry / exit accepted this cycle |
| occupancy | out | 8 | One bit per slot, 1 = occupied |
| count | out | 4 | Vehicles parked (0 to 8) |
| free_count | out | 4 | Free slots (8 - count, from the subtractor) |
| ticket_rd | out | 4 | Ticket stored in slot `exit_slot` (0 = empty) |
| full, empty | out | 1 | Lot flags |
| seg_occ | out | 7 | Display 1: vehicles parked |
| seg_free | out | 7 | Display 2: free slots |
| seg_slot | out | 7 | Display 3: next slot to be allocated ('-' when full) |
| seg_tkt | out | 7 | Display 4: ticket stored in `exit_slot` |
| status | out | 2 | 00 empty, 01 available, 10 almost full, 11 full |

Segment code is {a,b,c,d,e,f,g}, common cathode.

## 2. Components used

| Module | Type | Used in | Built from |
|---|---|---|---|
| dff_r | Flip-flop | edge_detect, occupancy_register, counters | D flip-flop, sync reset |
| edge_detect | Sequential | Top (x2) | 1 D flip-flop + AND gate with inverter |
| decoder3to8 | Decoder | Parts 1, 2 | AND gates + NOT, with enable |
| mux8to1 | Multiplexer | Part 2 | 8:1 mux |
| priority_encoder8 | Priority encoder | Part 1 | 8-to-3, bit 0 highest priority |
| full_adder | Arithmetic | adder4 | 2 XOR, 2 AND, 1 OR |
| adder4 | Arithmetic | Counters, subtractor | 4 full adders, ripple carry |
| subtractor4 | Arithmetic | Part 4 | adder4 with inverted B and carry-in 1 |
| entry_slot_allocator | Part 1 | Top | Priority encoder, AND gate, decoder |
| exit_slot_release | Part 2 | Top | Mux, AND gate, decoder |
| occupancy_register | Part 3 | Top | 8 D flip-flops, AND/OR/NOT gates |
| vehicle_counter | Part 3 | Top | adder4 + 4 D flip-flops (up/down) |
| ticket_counter | Part 3 | Top | adder4 + 4 D flip-flops |
| slot_memory | Part 3 | Top | 8 x 4-bit memory, 1 write port, 1 clear port, 1 read port |
| seven_seg_decoder | Decoder | Part 4 (x4) | 4-bit hex to 7-segment |
| availability_display | Part 4 | Top | Subtractor, comparators, gates, 4 display decoders |
| smart_parking_top | Top | - | All of the above, positional port mapping |

Gate primitives used: `and`, `or`, `xor`, `buf`, `~` (NOT). There are no `+` or `-` operators in the datapath. All addition and subtraction goes through `adder4` and `subtractor4`.

## 3. Working

**Input conditioning.** Each request goes through an edge detector, so holding a button for many clock cycles gives only one single-cycle pulse.

**Part 1 - Entry and allocation.**
1. The occupancy bits are inverted to give a free-slot vector.
2. The priority encoder gives the lowest free slot (`alloc_slot`) and `valid` (any slot free).
3. `entry_ok = entry_pulse AND valid`, so entry is rejected when the lot is full.
4. The decoder turns `alloc_slot` into a one-hot "set" vector, enabled only when `entry_ok` = 1.

**Part 2 - Exit and release.**
1. The 8:1 mux, selected by `exit_slot`, reads that slot's occupancy bit.
2. `exit_ok = exit_pulse AND slot_occupied`, so an exit from a free slot is ignored.
3. The decoder produces a one-hot "clear" vector, enabled only when `exit_ok` = 1.

**Part 3 - Occupancy register, counter and memory.**
- Each slot flip-flop has `D = set OR (Q AND NOT clear)`.
- The vehicle counter adds a step value to `count` through `adder4`. Entry only gives step 0001 (+1). Exit only gives 1111 (-1 in two's complement). Otherwise the step is 0000.
- The ticket counter adds 1 through `adder4` on every accepted entry. Its new value is the ticket number given to that car, so the first car gets ticket 1.
- The slot memory writes that ticket into the allocated slot on entry and writes 0 into the slot on exit. Reading with `exit_slot` returns the ticket parked there. The ticket counter is 4-bit, so it wraps after 15.

**Part 4 - Availability and display.**
- `free_count = 8 - count` using `subtractor4`.
- `full = count[3]`. `empty` = NOR of all count bits.
- `almost_full` = free_count is 1 or 2.
- `status`: bit1 = full OR almost_full, bit0 = full OR (NOT empty AND NOT almost_full).
- Four displays: vehicles parked, free slots, next slot (shows '-' when full), and ticket in the exit slot.

## 4. Testbench scenarios

1. Fill all 8 slots (slots 0 to 7, tickets 1 to 8).
2. Try a 9th car, which is rejected, so count stays 8 and no ticket is issued.
3. Cars leave slots 3 and 5 (tickets 4 and 6 read back from memory).
4. Exit from slot 5, which is already free, is ignored (ticket reads 0).
5. Two new cars take slots 3 and 5, getting tickets 9 and 10.
6. Empty the whole lot, giving count 0, `empty` = 1, status 00.
7. Exit on an empty lot is ignored.

Note: in the log, the rejected 9th entry still prints the previous `slot=` value. The count and occupancy lines show nothing changed.
