within BuildingSystems.HAM.HeatConduction;
model MultiLayerHeatConduction1DNodesHeatflow
  "Multilayer heat conduction with heatflows based on input temperature differences"
  extends MultiLayerHeatConduction1DNodes(
    redeclare HeatConduction1DNodesHeatflow layer(hasVariableHeatflow={if i==layerWithVariableHeatflows then true else false for i in 1:nLayers}));

  BuildingSystems.Interfaces.Temp_KOutput T_out[nNodes[layerWithVariableHeatflows]]
    "Temperature outputs"
    annotation (Placement(transformation(extent={{76,-54},{100,-30}})));

  BuildingSystems.Interfaces.Temp_KInput dT_in[nNodes[layerWithVariableHeatflows] + 1](each start=0)
    "Virtual temperature difference inputs of the nodes used for heat flow calculation"
    annotation (Placement(transformation(extent={{-98,-56},{-74,-32}})));

  parameter Integer layerWithVariableHeatflows
    "The layer number which exposes its temperature output and deltaT inputs";

equation

  connect(dT_in, layer[layerWithVariableHeatflows].dT_in);
  connect(T_out, layer[layerWithVariableHeatflows].T_out);


end MultiLayerHeatConduction1DNodesHeatflow;
