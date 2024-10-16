module AirTrafficControl(
    input radar,
    input wire weather, speed, range, altitude,  
    input wire [1:0] fuel,                      
    input wire emergency,                       
    input wire takeoff_signal,                  
    input wire [2:0] gate_number,               
    output reg [1:0] allocated_runway,          
    output reg [2:0] allocated_gate,            
    output reg timer_active,                    
    output reg [3:0] timer_value                
);

    // Runway availability and gate allocation status
    reg runway1_occupied = 0;  
    reg runway2_occupied = 0;  
    reg [2:0] next_gate_runway1 = 3'b001;  
    reg [2:0] next_gate_runway2 = 3'b100;
    
    always @(*) begin
        allocated_runway = 2'b00;  
        allocated_gate = 3'b000;   
        timer_active = 0;
        timer_value = 4'b0000;

        // Landing part
        if (emergency || (fuel == 2'b00)) begin
            // Emergency or fuel shortage, allocate runway 0 (emergency)
            allocated_runway = 2'b00;
            allocated_gate = 3'b000; 
        end
        else if (weather && speed && range && altitude && (fuel == 2'b10 || fuel == 2'b01)) begin
            // All conditions are optimum, allocate runway 1 first
            if (!runway1_occupied) begin
                allocated_runway = 2'b01;  
                allocated_gate = next_gate_runway1;
            end
            else if (!runway2_occupied) begin
                allocated_runway = 2'b10;  
                allocated_gate = next_gate_runway2;
            end
        end
        else if (!weather) begin
            // If weather is not good, start a 12-second timer before allocating
            timer_active = 1;
            timer_value = 4'b1100;
            allocated_runway = (!runway1_occupied) ? 2'b01 : 2'b10; 
            allocated_gate = (!runway1_occupied) ? next_gate_runway1 : next_gate_runway2;
        end
        else if (fuel == 2'b11) begin
            // Fuel is in excess, start a 15-second timer before allocating
            timer_active = 1;
            timer_value = 4'b1111;
            allocated_runway = (!runway1_occupied) ? 2'b01 : 2'b10;  
            allocated_gate = (!runway1_occupied) ? next_gate_runway1 : next_gate_runway2;
        end

        if (allocated_runway == 2'b01) begin
            next_gate_runway1 = next_gate_runway1 + 1;
            if (next_gate_runway1 > 3'b011) next_gate_runway1 = 3'b001;  // Reset gate to 1 after 3
            runway1_occupied = 1;
        end
        else if (allocated_runway == 2'b10) begin
            next_gate_runway2 = next_gate_runway2 + 1;
            if (next_gate_runway2 > 3'b110) next_gate_runway2 = 3'b100; 
            runway2_occupied = 1;
        end

        // Takeoff part
        if (takeoff_signal) begin
            if (!weather) begin
                // Weather is not good, start 15 seconds countdown
                timer_active = 1;
                timer_value = 4'b1111; 
            end
            allocated_runway = (gate_number <= 3) ? 2'b01 : 2'b10;  
        end
    end
endmodule

