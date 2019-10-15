within BuildingSystems.Buildings.Constructions.Walls;
model WallThermal1DNodesHeatflow
  extends WallThermal1DNodes(redeclare
      BuildingSystems.HAM.HeatConduction.MultiLayerHeatConduction1DNodesHeatflow
      construction(layerWithVariableHeatflows=layerWithVariableHeatflows));

  Interfaces.Temp_KOutput T_out[nNodesX](each start = T_start)
    "Temperature outputs"
    annotation (Placement(transformation(extent={{76,-54},{100,-30}})));

  Interfaces.Temp_KInput dT_in[layer[layerWithVariableHeatflows].nNodesX + 1](each start=0)
    "Virtual temperature difference inputs of the nodes used for heat flow calculation"
    annotation (Placement(transformation(extent={{-98,-56},{-74,-32}})));

  parameter Integer layerWithVariableHeatflows = 1
    "The layer number which exposes its temperature output and deltaT inputs";

equation
  connect(dT_in, construction.dT_in);
  connect(construction.T_out, T_out);

end WallThermal1DNodesHeatflow;
