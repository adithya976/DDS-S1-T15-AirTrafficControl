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

  ![Basic Structure](https://github.com/user-attachments/assets/48b6d6b2-4258-4859-89f3-08b8b56e760d)

 ###  Initial Inputs (Start)
 
  The process begins with the system receiving inputs from two different sources, depending on whether the aircraft is landing or taking off.
Landing:      The system gets inputs from a radar that detects an aircraft approaching for landing.
Takeoff:       The plane sends a signal indicating it’s ready to take off. This includes the gate number. 
Simultaneously, weather conditions are monitored to ensure it is safe for either landing or takeoff.

 ### Landing Process
  Flight Detection using Radar
  Once a flight is detected, the system receives data from multiple sensors aboard the plane, such as  speed, range, height, fuel level, and emergency status.
   Weather data is also gathered from the ATC.
  Mnimization of Errors Using Majority Voting Circuit
•	Logic Gate: Majority Voting Circuit (involves AND and OR gates).
   To ensure accurate input data, a majority voting circuit is used. This circuit minimizes the impact of faulty sensor readings.
   For instance, if three sensors are measuring the plane’s speed and two report a speed of 300 knots while one reports 310 knots, the system will choose the majority value.
   This improves reliability by eliminating outliers caused by faulty sensors.
   The system aggregates the majority of correct data for various sensor inputs such as speed, range, and height, using this logic.
   In essence, the majority voting circuit outputs the most frequently reported sensor value, ensuring the plane’s vital data is accurately processed.

  Fuel Status and Emergency Handling
  low fuel
   The system also checks the plane’s fuel level and whether there is any emergency situation.
It automatically considers the situation to be an emergency when fuel is low and when fuel is in excess, its let to be in air until it reaches optimum level. 
Emergency Handling 
The AND, OR  gate is used to detect emergencies by verifying two conditions:
	
  
  If both conditions are met, the AND gate outputs true, signaling an emergency.
  In such cases, the system immediately allocates a dedicated emergency runway and dispatches ground support vehicles such as ambulances and fire trucks to assist the aircraft.
  If no emergency is detected, the system proceeds with checking weather conditions and runway vacancy.
  Weather Checking and Runway Vacancy
   Once the plane’s status is confirmed (no emergency), the system checks the weather conditions  and whether the runway is available for landing.
   Weather Check Using OR Gate
  The OR gate is used to evaluate weather conditions.
 If any part of the weather input is favorable (such as visibility, wind speed, etc.), the system allows the operation to proceed.
For example, if visibility is good and wind speed is within limits, the OR gate outputs true, and the system moves to check runway availability.
However, if all weather conditions are unfavorable, the system waits until the weather improves. We use 12 second timer for that.
Runway Vacancy Using Counter
   Once weather conditions are favorable, the system checks runway availability. An AND gate verifies two conditions:
  	Weather is favorable.
	Runway is vacant.
  If both conditions are true, respective runway is assigned and the plane is cleared for landing.
  Runway Allocation 

   The counter is the core of this system, cycling through the values 0, 1, and 2 to handle the runway assignment.
 •	Counter Values:
  o	Counter = 0: Represents that Runway 1 is available and should be assigned.
  o	Counter = 1: Represents that Runway 2 is available and should be assigned.
  o	Counter = 2: No runway is available, so the timer circuit will be activated.
  If the runway is occupied, the system waits until it becomes vacant, or it engages a 15-second timer to avoid long delays.
  Once the timer stops, the counter is reset to 0 and the same process is repeated (in this case runway 1 is allocated).
  If weather is not good and fuel is excess then there is a timer of 12 second.
   Second Timer 
   If the runway remains occupied, the system initiates a 15-second timer.
   The NOT gate initially holds the allocation, but after 15 seconds, the signal flips, allowing the system to proceed even if the runway is still technically occupied. The AND gate checks that both the weather 
  remains favorable and the 15-second timer has expired. Once both conditions are met, the system allocates the runway for landing.
  Gate Allocation
  The system checks the corresponding gates using the D flip-flops. Each D flip-flop stores either a 0 (indicating the gate is free) or a 1 (indicating the gate is occupied). 
  The system sequentially checks each flip-flop to determine if a gate is available:
	If a gate's flip-flop stores 0, that gate is immediately assigned to the aircraft, and the flip-flop is updated to store 1, marking the gate as occupied.
	If the flip-flop stores 1, the system continues to check the next gate in the sequence.
  In cases where all gates for the selected runway are occupied (i.e., all flip-flops store 1), a timer is triggered. 
  After a specified period, the timer automatically makes one gate vacant by resetting its flip-flop to 0, indicating the gate is free for assignment.
  The system then assigns the newly vacated gate to the aircraft and updates the flip-flop accordingly.
  This method ensures efficient gate utilization while maintaining real-time tracking of gate statuses through the D flip-flops. 
  The memory of the system is dynamically updated based on the status of the gates, ensuring that the system operates smoothly even during peak traffic periods.

### Takeoff
   Takeoff Clearance
   Once the system confirms the runway is clear and weather conditions are favorable, the plane is cleared for takeoff.
   If the runway is occupied for more than 15 seconds, the system forces the allocation to avoid excessive delays.
   Once the plane takes off, it exits the system.
   	Weather Input:
   	This input ensures that the system only allows takeoffs when weather conditions are clear.
   It works in conjunction with logic gates (AND/OR) to either allow or block the process based on the weather.
   	Gate Inputs:
   	Planes waiting for takeoff are represented by gate inputs. Gates 1, 2, and 3 correspond to Runway 1, while Gates 4, 5, and 6 correspond to Runway
    The system prioritizes runway assignment based on the plane’s gate: Runway 1 for gates 1–3, and Runway 2 for gates 4–6.
   	Runway Assigner:
     This module checks the availability of the preferred runway based on gate input.
    If the preferred runway is busy, the system assigns the other runway.
    If both runways are occupied, it triggers a 15-second timer before rechecking availability.
  	Timers:
   	A 12-second timer is used once a runway is assigned to check if the weather remains clear. After the timer finishes, the plane can proceed if conditions are favorable.
    A 15-second timer is triggered if both runways are busy, pausing the system before rechecking runway availability.
      Logic Gates and Runway Status:
  	Logic gates like AND and OR manage the flow of signals, ensuring that takeoffs are only allowed when both the runway is free and the weather is clear. The system also tracks the status of runways (busy or 
     free) using these gates.


  In essence, this circuit automates runway assignments, using logic gates and timers to manage conflicts, weather conditions, and runway availability effectively.
  In summary, the ATC system uses logic gates and a timer to manage inputs and conditions effectively.
  The gates ensure that all necessary factors, such as weather, runway availability, and emergency status, are checked and validated before an aircraft is cleared for takeoff or landing.
  The 12-second and 15 second timer helps prevent unnecessary delays, making the system efficient and responsive.



  
</details>

## Logisim
<details>
  <summary>Detail</summary><br>  

  ### Main Circuit:
  ![MainCircuit](https://github.com/user-attachments/assets/65655b83-6c2e-4058-aa21-55c54a48d77b)


### Radar Input:
![Radar Input](https://github.com/user-attachments/assets/709f26f1-416b-45c6-bcb4-939615090a14)

### Basic Plane Inputs:
![Plane Input](https://github.com/user-attachments/assets/3a55c208-2f63-4706-8e0d-e993521ab382)

### Fuel Inputs:
![Fuel](https://github.com/user-attachments/assets/4ed100ee-235d-48da-940a-0cd8a7c7ba33)


### Majority Circuit Voting:
![Majority Voting Circuit](https://github.com/user-attachments/assets/e4d686e0-f012-4a0b-8244-25b1461a1dd8)

### Counter:
![Counter](https://github.com/user-attachments/assets/c3eabb94-da63-4d7a-bc51-0e5707d3fff5)

### Timer 12 sec:
![Timer 12](https://github.com/user-attachments/assets/57dcde00-4f99-4b2c-86eb-2bf0607d6338)


### Timer 15 sec:
![Timer 15](https://github.com/user-attachments/assets/1ea9113c-757e-4d9d-b14a-b3894b9dbe03)


### Binary To BCD:
![Binary To BCD](https://github.com/user-attachments/assets/abc5d38f-f67d-4bd9-b50e-35fc7ca7c5aa)


### BCD To Display:

![BCD To Display](https://github.com/user-attachments/assets/fbbb09b2-a8b4-4dc1-82ed-de3cd5bfc10e)


### Pulse Generator:
![Pulse Generator](https://github.com/user-attachments/assets/3b0129f5-300e-4ab4-a7ed-d888ef0085d5)



### Binary To Display:
![Binary to Display](https://github.com/user-attachments/assets/7d24819a-bc04-4543-9dd1-629c69cbfe91)


### Gate Chooser Display:

![Gate chooser display](https://github.com/user-attachments/assets/19071ceb-c179-41f6-86fc-30b61c057a52)

### Gate Number Display:

![Gate Display](https://github.com/user-attachments/assets/03a25d7a-93fe-4711-ac9f-7adb534b430a)


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


