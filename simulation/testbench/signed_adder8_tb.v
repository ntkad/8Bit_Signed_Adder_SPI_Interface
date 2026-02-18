`timescale 1ns/1ps

module signed_adder8_tb;

   //SPI Signals
   reg        SCLK;
   reg        rst_n;
   reg        CSN;
   reg        MOSI;
   wire       MISO;
   wire       MISO_enable;

   //error-counter
   reg [7:0]  error_count;

   //debug/visualization Signal for Waveform
   reg [7:0]  debug_miso_byte; 

   // Instantiate DUT
   signed_adder8 uut (
      .SCLK(SCLK),
      .rst_n(rst_n),
      .MOSI(MOSI),
      .CSN(CSN),
      .MISO(MISO),
      .MISO_enable(MISO_enable)
   );


   //Clock generation =100 MHz(10ns period)
   initial SCLK = 0;
   always #5 SCLK = ~SCLK;


   //Comparison function
   function [7:0] compare_outputs (
   
                                   input [7:0]    expected_value,
                                   input [7:0]    actual_value,
                                   input [8*19:0] signal_name,
                                   input [7:0]    error_count);
                                   
      if (expected_value == actual_value ) begin
         $display("  PASS  : %s: Expected = %h, Actual = %h, Time = %t",
                  signal_name, expected_value, actual_value, $time);
         compare_outputs = error_count;
         
      end else begin
         $display("**FAIL**: %s: Expected = %h, Actual = %h, Time = %t",
                  signal_name, expected_value, actual_value, $time);
         compare_outputs = error_count + 1;
      end
   endfunction 

   //*******
   // SPI Tasks
   //*******
   
   // WRITE TASK
   task write_spi;
      input [1:0] addr;
      input [7:0] data;
      reg [11:0]  frame;
      integer     i;
      
      begin
          //frame = {R/W(1), Addr(2), Dead(1), Data(8)}
          //R/W = 1 for Write
          frame = {1'b1, addr, 1'b0, data}; 

          @(negedge SCLK);
          CSN = 0;    //start transaction

          //shift out 12 bits on falling rdge
          for (i = 11; i >= 0; i = i-1) begin
              MOSI = frame[i];
              @(negedge SCLK); 
          end

          CSN = 1;     //end transaction
          MOSI = 0;
          #20;    //idle gap
      end
   endtask



   // READ TASK
   task read_spi;
      input [1:0]  addr;
      output [7:0] data_out;
      reg [11:0]   frame;
      integer      i;
      
      begin
          //frame = {R/W(1), Addr(2), Dead(1), Data(8)}
          // R/W = 0 for Read
          frame = {1'b0, addr, 1'b0, 8'h00};
          data_out = 0;

          @(negedge SCLK);
          CSN = 0;

          //sending command (Bits 11-8)
          for (i = 11; i >= 8; i = i-1) begin
              MOSI = frame[i];
              @(negedge SCLK);
          end

          //receive data (Bits 7-0)
          for (i = 7; i >= 0; i = i - 1) begin
              @(posedge SCLK); 
              data_out[i] = MISO;
          end
          @(negedge SCLK); // Finish last cycle
          
          //updating debug singal
          debug_miso_byte = data_out; 

          CSN = 1;
          MOSI = 0;
          #20;
      end
   endtask
   

   //TEST CASE TASK
   
   task run_case_spi;
      input signed [7:0] a;
      input signed [7:0] b;
      reg signed [7:0]  res_read;
      reg [7:0]         status_read;
      
      //expected values
      reg signed [8:0]   exp_full_sum;
      reg signed [7:0]  exp_sum;
      reg               exp_ovf;
      reg               exp_unf;
      
      begin
          // 1. Calculate Expected
          exp_full_sum = a + b;
          exp_sum    = exp_full_sum[7:0];
          exp_ovf   = (~a[7]) & (~b[7]) & (exp_sum[7]);
          exp_unf    = ( a[7]) & ( b[7]) & (~exp_sum[7]);

          //2. Drive SPI
          write_spi(2'b00, a);     //write A
          write_spi(2'b01, b);      //write B
          write_spi(2'b11, 8'h01);   //write Status (Bit 0 = Start)

          //3.Wait for Adder Latency
          
          //4. Read Results
          read_spi(2'b10, res_read); //read Result
          read_spi(2'b11, status_read); //read Status

          // 5. Check using compare_outputs function
          error_count = compare_outputs(exp_sum, res_read, "adder_out", error_count);
          
          //check Flags (Bit 5=OVF, Bit 4=UNF)
          //pad single bits with zeros to match 8-bit function input
          error_count = compare_outputs({7'b0, exp_ovf}, {7'b0, status_read[5]},  "overflow",  error_count);
          error_count = compare_outputs({7'b0, exp_unf}, {7'b0, status_read[4]},  "underflow", error_count);

          $display("--------------------------------------------------");
      end
   endtask


   //the Main Block
   initial begin
      $dumpfile("signed_adder8_spi.vcd");
      $dumpvars(0, signed_adder8_tb);

      error_count = 0;
      debug_miso_byte = 0;  //initialize debug signal
      rst_n = 0;
      CSN = 1;
      MOSI = 0;

      #20 rst_n = 1;
      #20;

      //Normal Cases
      run_case_spi(8'sd10, 8'sd20);
      run_case_spi(-8'sd10, 8'sd20);
      
      //Overflow Cases
      run_case_spi(8'sd100, 8'sd50);    // 150-Overflow
      
      //Underflow Cases
      run_case_spi(-8'sd100, -8'sd50);  //-150-Underflow
 
      if (error_count == 0) begin
         $display("\n\n----------SIMULATION PASSED----------");
         $display("----------RTL SIMULATION   ----------\n\n");
      end else begin
         $display("\n\n----------SIMULATION FAILED----------");
         $display("----------RTL SIMULATION   ----------");
         $display("---------- %d ERRORS TOTAL----------\n\n", error_count);
      end

      $finish;
   end

endmodule