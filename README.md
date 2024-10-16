# Real Time Air Traffic Control System

## Team Details
<details>
  <summary>Detail</summary>

  > Semester: 3rd Sem B. Tech. CSE

  > Section: S1

  > Member-1: Himanshu Singh Patel, 231CS127, himanshusinghpatel.231cs127@nitk.edu.in

  > Member-2: Nishant Kumar, 231CS140, nishantkumar.231cs140@nitk.edu.in

  > Member-3: R Adithya, 231CS146, r.231cs146@nitk.edu.in
</details>


## Abstract
<details>
  <summary>Detail</summary>
  
### Problem Statement and Solution:
  
 This project focuses on developing a Real-Time Air Traffic Control system utilizing digital logic gates to automate key tasks performed by airport control towers. Air traffic control (ATC) is critical for ensuring the safe and efficient operation of airports, where numerous tasks like managing landings, take-offs, and emergencies are traditionally handled by humans. However, human intervention is prone to errors. To address this, we present a fully automated Real-Time Air Traffic Control system, which performs all essential tasks such as runway clearance, weather sensing, terminal and gate chooser and emergency management without manual input. It replaces manual operations with a fully automated process. 
  
### Motivation:
 The motivation for this project arises from the need to reduce human intervention in ATC processes and minimize the possibility of human error, particularly in critical situations like emergency landings and many more. By leveraging digital circuits, the system ensures faster, more accurate decision-making in real-time, thereby enhancing both safety and operational efficiency. In an environment where even minor delays or mistakes can have serious consequences, automating such processes can significantly improve airport management, especially when multiple variables like weather conditions, runway availability, and aircraft fuel status must be considered simultaneously.

### Features:
 Our contribution lies in developing an automated ATC system that receives data from aircraft sensors—range, speed, altitude, and fuel level—as well as weather sensors. A majority voting circuit is incorporated to reduce errors in the sensor inputs, ensuring accurate and reliable data processing. We have integrated a RADAR detection feature, which monitors incoming planes approaching the airport for landing. One of the unique features of this project includes automatic emergency management feature. When an aircraft’s fuel level is critically low or if it has any damage, the system designates it as an emergency, prioritizes its landing, and dispatches ground vehicles to assist. If an aircraft’s fuel is too high, the system prevents it from landing until the fuel level reaches a safe threshold, avoiding potential risks. The system handles emergencies, prioritizes aircraft based on fuel status and other features, and improves the overall safety and reliability of airport operations through a fully automated process.
</details>

## Functional Block Diagram
<details>
  <summary>Detail</summary><br>
  <details>
  <summary>Detailed Diagram:</summary><br>

![S1-T15-ATC drawio1](https://github.com/user-attachments/assets/2180479f-c7b7-4f76-8cf6-069899c3aba1)  
</details>
  
  

Simplified Diagram:

![S1-T15 simplifiedATC drawio](https://github.com/user-attachments/assets/239b9ec2-c1e0-4eae-b124-1f402589f111)

</details>


## Working
<details>
  <summary>Detail</summary>

  ![image](https://github.com/user-attachments/assets/240a793a-cd5b-4d06-8e10-f36563ebce8b)
</details>

## Logisim
<details>
  <summary>Detail</summary>

  > Update a neat logisim circuit diagram
</details>

## Verilog Code
<details>
  <summary>Detail</summary>
  
  ### Gatelevel

    module AirTrafficControl(
    input wire weather, speed, range, altitude,  
    input wire [1:0] fuel,                      
    input wire emergency,                       
    input wire takeoff_signal,                  
    input wire [2:0] gate_number,               
    output wire [1:0] allocated_runway,         
    output wire [2:0] allocated_gate,           
    output wire timer_active,                   
    output wire [3:0] timer_value               
    );

    wire opt_conditions, fuel_ok, fuel_excess, fuel_shortage;
    wire runway1_available, runway2_available, use_runway1, use_runway2;
    wire [1:0] selected_runway;

    // Weather, speed, range, altitude should be optimum
    and (opt_conditions, weather, speed, range, altitude);

    // Check fuel status: 
    and (fuel_ok, ~fuel[1], fuel[0]);  
    and (fuel_excess, fuel[1], fuel[0]);  
    and (fuel_shortage, ~fuel[1], ~fuel[0]);  

    // Emergency case or fuel shortage --> allocate runway 0
    wire emergency_or_fuel_shortage;
    or (emergency_or_fuel_shortage, emergency, fuel_shortage);

    // Runway allocation logic
    wire runway1_free, runway2_free;  
    not (runway1_available, runway1_free);  
    not (runway2_available, runway2_free); 

    // Runway 1 allocation if all conditions are optimum and it's available
    and (use_runway1, opt_conditions, runway1_available, fuel_ok);

    // Runway 2 allocation if Runway 1 is occupied and it's available
    and (use_runway2, opt_conditions, runway2_available, fuel_ok);

        assign selected_runway = (use_runway1) ? 2'b01 : 
                             (use_runway2) ? 2'b10 : 
      2'b00;  

    // Output assigned runway
    assign allocated_runway = emergency_or_fuel_shortage ? 2'b00 : selected_runway;

    // Simple gate allocation: this is a simplified version
    wire [2:0] next_gate_runway1 = 3'b001;  // Fixed gate numbers for now
    wire [2:0] next_gate_runway2 = 3'b100;

    assign allocated_gate = (allocated_runway == 2'b01) ? next_gate_runway1 :
                            (allocated_runway == 2'b10) ? next_gate_runway2 : 3'b000;  // Default gate 0 for runway 0

    // Timer logic
    wire weather_bad, start_timer_fuel_excess;
    not (weather_bad, weather);
    and (start_timer_fuel_excess, fuel_excess, ~emergency);

    assign timer_active = weather_bad | start_timer_fuel_excess;
    assign timer_value = (weather_bad) ? 4'b1100 :  // 12 seconds
                        (start_timer_fuel_excess) ? 4'b1111 :  // 15 seconds
                        4'b0000;  // Default, no timer

    endmodule

  ### Behavioural 
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


### Testbench

     module AirTrafficControl_tb;

    // Inputs
    reg radar;
    reg weather;
    reg speed;
    reg range;
    reg altitude;
    reg [1:0] fuel;
    reg emergency;
    reg takeoff_signal;
    reg [2:0] gate_number;

    // Outputs
    wire [1:0] allocated_runway;
    wire [2:0] allocated_gate;
    wire timer_active;
    wire [3:0] timer_value;

    AirTrafficControl uut (
        .weather(weather), 
        .speed(speed), 
        .range(range), 
        .altitude(altitude), 
        .fuel(fuel), 
        .emergency(emergency), 
        .takeoff_signal(takeoff_signal), 
        .gate_number(gate_number), 
        .allocated_runway(allocated_runway), 
        .allocated_gate(allocated_gate), 
        .timer_active(timer_active), 
        .timer_value(timer_value)
    );

    initial begin
        $monitor("Time: %4t | Emergency: %b | Weather: %b | Speed: %b | Range: %b | Altitude: %b | Fuel: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b | Allocated Gate: %b ", 
            $time, emergency, weather, speed, range, altitude, fuel, timer_active, timer_value, allocated_runway, allocated_gate);

        // Initialize Inputs
        radar = 0;
        weather = 1;
        speed = 1;
        range = 1;
        altitude = 1;
        fuel = 2'b00;
        emergency = 0;
        takeoff_signal = 0;
        gate_number = 3'b000;

        // Emergency scenario - Runway 0 should be allocated
        #10;
        radar= 1;
        emergency = 1;
        #10 fuel = 2'b01;

        //  Fuel shortage (emergency scenario) - Runway 0 should be allocated
        #10  emergency = 0;

        //Everything normal
        #10  fuel = 2'b01;  

        // Weather not good - Start 12-second timer, then allocate available runway
        #10 weather = 1;
        #10 weather = 0; 

        //  Fuel excess - Start 15-second timer, then allocate available runway
        #10 fuel = 2'b11; 
        #10 fuel = 2'b10; 

        // Takeoff Part//
        // Weather not good for takeoff, timer countdown
        #10 takeoff_signal = 1; gate_number = 3'b001; weather = 0;

        $monitor("Time: %4t | Weather: %b | Takeoff Signal: %b | Gate: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b ", 
            $time, weather, takeoff_signal, gate_number, timer_active, timer_value, allocated_runway);

        #10 weather = 1; 

        // Test 8: Takeoff with gate 4, Runway 2 should be allocated
        #10 gate_number = 3'b100; 
        #10 gate_number = 3'b110;

        #10 $finish;
    end

    endmodule






   
</details>


