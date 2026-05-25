\# Synthesis Notes and Scope Status



This milestone focused on integrating the interface module and compute core into a complete end-to-end hardware system and successfully synthesizing the design using OpenLane 2.



The integrated top module was implemented in `project/m3/rtl/top.sv`. The design instantiates both the interface module and compute core and connects them together using internal handshake and data signals. The interface receives host-side inputs and forwards them into the compute engine. The compute engine processes the data and returns results through the interface path.



An end-to-end co-simulation testbench was created in `project/m3/tb/tb\_top.sv`. The testbench drives the interface from the host side instead of directly modifying internal compute signals. This verifies the complete data flow path required by the milestone. During simulation, the testbench applied multiple input values, waited for processing to complete, and compared the returned results against independently calculated expected outputs. The simulation produced a PASS result, confirming correct operation of the integrated design.



Waveforms were captured using GTKWave and saved as `cosim\_waveform.png`. The waveform shows clock activity, reset behavior, interface transactions, compute activity, and result generation.



OpenLane 2 synthesis was successfully completed using Docker and the OpenLane 2 container flow. The synthesis generated timing, area, and power reports. Timing analysis showed positive slack, indicating that the design met the selected clock target without setup timing violations. Area reports showed the number of synthesized standard cells and total design area after logic mapping and optimization. Power estimation reports were also generated successfully.



Several issues were encountered during development and synthesis. Initial integration attempts failed because some interface port names in the top module did not match the actual ports defined inside the interface module. These errors were corrected by updating the signal names and rebuilding the design. Additional issues occurred during Docker setup and OpenLane installation due to limited storage space inside the Linux virtual machine environment. The synthesis flow was eventually moved to Docker Desktop on Windows, which resolved the storage limitations.



The project scope remains unchanged. The integrated compute and interface architecture defined earlier in the course was preserved. The current design successfully demonstrates end-to-end functionality, synthesis capability, and timing closure required for Milestone 3.

