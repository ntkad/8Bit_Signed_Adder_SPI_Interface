`timescale 1ns/1ps

module signed_adder8 (
    input  wire rst_n,        // Active-low async reset
    input  wire SCLK,         // Serial Clock (100 MHz free-running)
    input  wire MOSI,         // Master Out Slave In
    input  wire CSN,          // Active-low Chip Select
    output reg  MISO,         // Slave Out Master In
    output reg  MISO_enable   // Active-high enable for MISO
);

    //internal Registers for SPI Map
    reg signed [7:0] reg_input_a;  // Addr 00
    reg signed [7:0] reg_input_b;  // Addr 01
    reg signed [7:0] reg_result;   // Addr 10
    reg        [7:0] reg_status;   // Addr 11 (Stores OVF/UNF)


    //ointernal Wires from
    wire signed [7:0] core_sum;
    wire  core_ovf;
    wire  core_unf;
    

    // SPI State Signals
    reg [3:0]  bit_cnt;        //counts 11 down to 0
    reg        rw_bit;         //0=read,1=write
    reg [1:0]  addr_latched;   //stores bits 10:9
    reg [7:0]  shift_in_reg;   //accumulates MOSI data
    reg [7:0]  shift_out_reg;  //loaded for MISO data
    
    //start Logic
    reg  start_capture;  //pulses when start command is received

  
    //instantiate the original arithmetic logic
    signed_adder8_core u_core (
        .clk       (SCLK),   //SCLK acting as system clock
        .rst_n     (rst_n),
        .input_a   (reg_input_a),
        .input_b   (reg_input_b),
        .adder_out (core_sum),
        .overflow  (core_ovf),
        .underflow (core_unf)
    );




    
    // SPI Control Logic (Synchronous to SCLK)
    always @(posedge SCLK or negedge rst_n) begin
        if (!rst_n) begin
            bit_cnt      <= 11;
            reg_input_a  <= 8'd0;
            reg_input_b  <= 8'd0;
            reg_result   <= 8'd0;
            reg_status   <= 8'd0;
            MISO_enable  <= 0;
            shift_in_reg <= 8'd0;
            addr_latched <= 2'b00;
            rw_bit       <= 1'b0;
            start_capture<= 0;
            
        end else begin
        
            // Default Start Pulse low
            start_capture <= 0;

            // Capture results if Start bit was set
            if (start_capture) begin
                reg_result <= core_sum;
                
                //status format: xxou_xxxs (Bits 5=OVF, 4=UNF)
                reg_status[5] <= core_ovf;
                reg_status[4] <= core_unf;
            end

            if (CSN) begin
                // Reset SPI interface when CSN is High
                bit_cnt     <= 11;
                MISO_enable <= 0;
                
            end else begin
            
                // --- Transaction Active ---
                
                // Address/Command Phase (Bits 11-8)
                if (bit_cnt == 11) rw_bit       <= MOSI;
                if (bit_cnt == 10) addr_latched[1] <= MOSI;
                if (bit_cnt == 9)  addr_latched[0] <= MOSI;
                
                // Prepare for Data Phase (at end of Bit 8)
                if (bit_cnt == 8) begin
                    if (rw_bit == 0) begin 
                        // READ: Load output register
                        MISO_enable <= 1; 
                        case (addr_latched)
                            2'b00: shift_out_reg <= reg_input_a;
                            2'b01: shift_out_reg <= reg_input_b;
                            2'b10: shift_out_reg <= reg_result;
                            2'b11: shift_out_reg <= reg_status;
                        endcase
                    end else begin
                        // WRITE: Ensure MISO is off
                        MISO_enable <= 0;
                    end
                end

                // Data Phase (Bits 7-0): Shift In for Writes
                if (bit_cnt <= 7 && rw_bit == 1) begin
                    shift_in_reg <= {shift_in_reg[6:0], MOSI};
                    
                    //end of transaction:updating Registers
                    if (bit_cnt == 0) begin
                        case (addr_latched)
                            2'b00: reg_input_a <= {shift_in_reg[6:0], MOSI};
                            2'b01: reg_input_b <= {shift_in_reg[6:0], MOSI};
                           
                            2'b11: begin
                            
                                // Bit 0 is Start
                                if (MOSI == 1'b1) start_capture <= 1; 
                            end
                        endcase
                    end
                end

                //decrement Counter
                if (bit_cnt > 0) bit_cnt <= bit_cnt - 1;
            end
        end
    end




    // MISO Output Logic (Negative Edge)
    
    always @(negedge SCLK or negedge rst_n) begin
        if (!rst_n) begin
            MISO <= 0;
        end else if (!CSN && MISO_enable && bit_cnt <= 7) begin
            // Output MSB of current shift register
            MISO <= shift_out_reg[bit_cnt]; 
        end else begin
            MISO <= 0;
        end
    end

endmodule






// Original Adder Logic (from project 1)

module signed_adder8_core (
    input  wire  clk,          
    input  wire rst_n,        
    input  wire [7:0] input_a,      
    input  wire [7:0] input_b,      
    output reg  [7:0] adder_out,    
    output reg        overflow,     
    output reg        underflow     
);
    // Registered inputs
    reg signed [7:0] a_reg;
    reg signed [7:0] b_reg;
    // Combinational signals
    reg signed [8:0] sum_ext;
    reg signed [7:0] sum_comb;
    reg ovf_comb;
    reg unf_comb;

    always @(*) begin
    
        //func1: Signed addition using extended width
        sum_ext  = {a_reg[7], a_reg} + {b_reg[7], b_reg};
        sum_comb = sum_ext[7:0];
        
        //func2: Overflow / Underflow detection
        ovf_comb = (~a_reg[7]) & (~b_reg[7]) & (sum_comb[7]);
        unf_comb = ( a_reg[7]) & ( b_reg[7]) & (~sum_comb[7]); 
    end

     Sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_reg     <= 0;
            b_reg     <= 0;
            adder_out <= 0;
            overflow  <= 0;
            underflow <= 0;              
        end else begin
        
            //func3: Register inputs
            a_reg <= input_a;
            b_reg <= input_b;
            
            //func4: Register outputs
            adder_out <= sum_comb;
            overflow  <= ovf_comb;
            underflow <= unf_comb;
        end
    end
endmodule