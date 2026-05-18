\# M3 Plan



For M3, I plan to improve the synthesized design by fixing the small setup timing violation. The OpenLane run used a 10 ns clock period, but the worst setup slack was -0.0638 ns with 2 setup violations. Since the violation is small, the first option is to relax the clock period slightly, for example from 10 ns to 11 ns, and rerun synthesis to confirm timing closure.



If the project needs to keep the 10 ns target, I will add a pipeline stage in the MAC datapath. The likely critical path is through the combinational add/subtract logic that forms the output sums. Pipelining would reduce the amount of logic between registers and should improve setup slack. I will also check the 5 max slew violations and 4 max fanout violations, because these may need buffering or small HDL changes. Since area is 5571.59 and the design has 808 standard cells, the design size is still reasonable for M3.

