within BuildingSystems.HAM.HeatConduction;
model MultiLayerHeatConduction1DNodesHeatflow
  "Multilayer heat conduction with heatflows based on input temperature differences"
  extends MultiLayerHeatConduction1DNodes(
    redeclare HeatConduction1DNodesHeatflow layer(hasVariableHeatflow={i==layerWithVariableHeatflows for i in 1:nLayers}));

  Interfaces.Temp_KOutput T_out[nNodesX](each start = T_start)
    "Temperature outputs"
    annotation (Placement(transformation(extent={{76,-54},{100,-30}})));

  Interfaces.Temp_KInput dT_in[layer[layerWithVariableHeatflows].nNodesX + 1](each start=0)
    "Virtual temperature difference inputs of the nodes used for heat flow calculation"
    annotation (Placement(transformation(extent={{-98,-56},{-74,-32}})));

  parameter Integer layerWithVariableHeatflows = 1
    "The layer number which exposes its temperature output and deltaT inputs";

equation

  connect(dT_in, layer[layerWithVariableHeatflows].dT_in);


end MultiLayerHeatConduction1DNodesHeatflow;
