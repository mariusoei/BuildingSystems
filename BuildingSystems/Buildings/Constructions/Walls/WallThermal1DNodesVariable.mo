within BuildingSystems.Buildings.Constructions.Walls;
model WallThermal1DNodesVariable
  "Thermal wall model with 1D discritisation of the single layers"
  extends BuildingSystems.Buildings.BaseClasses.WallThermalGeneral;

  BuildingSystems.Interfaces.HeatPort heatPort_source if heatSource
    annotation (Placement(transformation(extent={{10,-48},{30,-28}}),
      iconTransformation(extent={{10,-48},{30,-28}})));

  BuildingSystems.HAM.HeatConduction.MultiLayerHeatConduction1DNodesVariable construction(
    lengthY=width,
    lengthZ=height,
    nLayers=constructionData.nLayers,
    nNodes=nNodes,
    thickness=constructionData.thickness,
    material=constructionData.material,
    T_start=T_start,
    layerWithHeatSource=layerWithHeatSource,
    nodeWithHeatSource=nodeWithHeatSource,
    layerWithVariableConduction=layerWithVariableConduction)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  parameter Integer nNodes[constructionData.nLayers] = fill(1,constructionData.nLayers)
    "Number of numerical nodes of each layer"
    annotation(Dialog(tab = "Advanced", group = "Numerical Parameters"));
  parameter Integer nodeWithHeatSource = 1
    "Numerical node of the specified layer with internal heat source"
    annotation(Dialog(tab = "Advanced", group = "Heat sources"));


  parameter Integer layerWithVariableConduction = 1
    "Material layer with variable heat conduction";

  parameter Boolean show_TSur = false
    "Show surface temperatures on both sides"
    annotation(Dialog(tab = "Advanced", group = "Surface variables"));
  BuildingSystems.Interfaces.Temp_KOutput TSur_1 = toSurfacePort_1.heatPort.T if show_TSur
    "Temperature on surface side 1"
    annotation (Placement(transformation(extent={{-40,10},{-60,30}}),
      iconTransformation(extent={{-20,10},{-40,30}})));
  BuildingSystems.Interfaces.Temp_KOutput TSur_2 = toSurfacePort_2.heatPort.T if show_TSur
    "Temperature on surface side 2"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},origin={50,20}),
      iconTransformation(extent={{20,10},{40,30}})));

  Modelica.Blocks.Interfaces.RealInput conductionMultiplier
    annotation (Placement(transformation(extent={{-40,-46},{-20,-26}}),
        iconTransformation(extent={{-40,-46},{-20,-26}})));


equation
  connect(heatPort_source, construction.heatPort_source);
  connect(toSurfacePort_1.moisturePort, moistBcPort1.moisturePort) annotation (Line(
    points={{-20,0},{-20,-11.2}},
    color={0,0,0},
    pattern=LinePattern.Solid,
    smooth=Smooth.None));
  connect(toSurfacePort_2.moisturePort, moistBcPort2.moisturePort) annotation (Line(
      points={{20,0},{20,-11.2}},
      color={0,0,0},
      pattern=LinePattern.Solid,
      smooth=Smooth.None));
  connect(construction.heatPort_x2, toSurfacePort_2.heatPort) annotation (Line(
      points={{8,0},{20,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(toSurfacePort_1.heatPort, construction.heatPort_x1) annotation (Line(
      points={{-20,0},{-8,0}},
      color={0,0,0},
      pattern=LinePattern.Solid,
      smooth=Smooth.None));

  connect(conductionMultiplier, construction.conductionMultiplier) annotation (
     Line(points={{-30,-36},{-12,-36},{-12,-4.7},{-8.3,-4.7}}, color={0,0,127}));

  annotation (defaultComponentName="wall", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),graphics={
    Text(extent={{-16,81},{16,38}}, lineColor={255,0,0},lineThickness=0.5,fillColor={255,128,0},
            fillPattern =                                                                                     FillPattern.Solid,textString = "1D"),
    Text(extent={{-66,146},{66,106}},lineColor={0,0,255},fillColor={230,230,230},
            fillPattern =                                                                      FillPattern.Solid,textString = "%name")}),
Documentation(info="<html>
<p>
This is a thermal wall model with 1D discritisation of the single layers.
</p>
</html>", revisions="<html>
<ul>
<li>
May 23, 2015 by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
end WallThermal1DNodesVariable;
