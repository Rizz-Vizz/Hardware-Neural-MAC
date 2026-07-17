@echo off
echo =======================================================
echo Setting up OSS CAD Suite Environment...
echo =======================================================
call "C:\Users\LENOVO\Downloads\osscadsuite\oss-cad-suite\environment.bat"

echo.
echo Running synthesis and saving all output to a text file...
echo This might take a few seconds, please wait...

(
echo =======================================================
echo 1. Running standard synthesis ^(Gate count^)
echo =======================================================
yosys synth.ys

echo.
echo =======================================================
echo 2. Running FPGA synthesis for iCE40
echo =======================================================
yosys -p "read_verilog half_adder.v full_adder.v ripple_adder_16.v multiplier.v accumulator.v relu.v mac_unit_pipelined.v neuron_layer.v; synth_ice40 -top neuron_layer -json neuron_layer.json"

echo.
echo =======================================================
echo 3. Running NextPNR ^(Placement and Routing^)
echo =======================================================
nextpnr-ice40 --hx8k --json neuron_layer.json --asc neuron_layer.asc --freq 50

echo.
echo =======================================================
echo 4. Running Icetime ^(Timing Analysis^)
echo =======================================================
icetime -d hx8k neuron_layer.asc
) > synthesis_logs.txt 2>&1

echo.
echo DONE! Opening the logs in Notepad so you can easily search them...
start notepad synthesis_logs.txt
