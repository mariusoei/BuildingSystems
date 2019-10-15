within BuildingSystems.Buildings.Constructions.Walls;
model WallThermal1DNodesHeatflow
  extends WallThermal1DNodes(redeclare
      BuildingSystems.HAM.HeatConduction.MultiLayerHeatConduction1DNodesHeatflow
      construction(layerWithVariableHeatflows=layerWithVariableHeatflows));

  BuildingSystems.Interfaces.Temp_KOutput T_out[nNodes[layerWithVariableHeatflows]]
    "Temperature outputs"
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},
        rotation=270,
        origin={18,-82})));

  BuildingSystems.Interfaces.Temp_KInput dT_in[nNodes[layerWithVariableHeatflows] + 1](each start=0)
    "Virtual temperature difference inputs of the nodes used for heat flow calculation"
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-10,-82})));

  parameter Integer layerWithVariableHeatflows = 1
    "The layer number which exposes its temperature output and deltaT inputs";

equation
  connect(dT_in, construction.dT_in);
  connect(construction.T_out, T_out);

end WallThermal1DNodesHeatflow;
