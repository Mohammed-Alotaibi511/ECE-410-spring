# M3 README



## Folder Overview



 `rtl/top.sv`  

Integrated top-level module connecting the interface and compute core.



`rtl/compute\_core.sv`  

Compute engine used for arithmetic processing.



 `rtl/interface.sv`  

Host-side interface module.



 `tb/tb\_top.sv`  

End-to-end co-simulation testbench.



 `sim/cosim\_run.log`  

Simulation transcript showing PASS output.



 `sim/cosim\_waveform.png`  

Waveform image captured from GTKWave.



\- `synth/config.json`  

OpenLane 2 synthesis configuration file.



 `synth/metrics.csv`  

OpenLane synthesis metrics output.



 `synth/timing\_report.txt`  

Timing analysis report.



 `synth/area\_report.txt`  

Area and cell utilization report.



 `synth/power\_report.txt`  

Power estimation report.



 `synth/critical\_path.md`  

Critical path explanation and timing discussion.



\- `synthesis\_notes.md`  

Narrative description of synthesis process, debugging, and project status.



## Simulation



Simulator used:

 Icarus Verilog

 GTKWave



Compile command:



```bash

iverilog -g2012 -o top\_sim project/m3/tb/tb\_top.sv project/m3/rtl/top.sv project/m3/rtl/compute\_core.sv project/m3/rtl/interface.sv

```



Run simulation:



```bash

vvp top\_sim

```



Open waveform:



```bash

gtkwave dump.vcd

```



## OpenLane Synthesis



OpenLane version:

 ghcr.io/efabless/openlane2:2.4.0.dev1



Run command:



```bash

docker run --rm -v "${PWD}:/work" -w /work/project/m3/synth ghcr.io/efabless/openlane2:2.4.0.dev1 openlane config.json

```

