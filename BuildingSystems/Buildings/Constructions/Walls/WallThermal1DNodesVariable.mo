within BuildingSystems.Buildings.Constructions.Walls;
model WallThermal1DNodesVariable
  "Thermal wall model with 1D discritisation of the single layers"
  extends BuildingSystems.Buildings.BaseClasses.WallThermalGeneral(
  toSurfacePort_1(epsilon=epsilon_1_internal),
  toSurfacePort_2(epsilon=epsilon_2_internal));


  parameter Boolean hasVariableEmissivity_1 = false
    "Get emissivity epsilon for surface 1 from input"
    annotation(Dialog(tab = "General", group = "Surfaces"));

  parameter Boolean hasVariableEmissivity_2 = false
    "Get emissivity epsilon for surface 2 from input"
    annotation(Dialog(tab = "General", group = "Surfaces"));

  parameter Boolean hasVariableAbsorptance_1 = false
    "Get absorptance abs for surface 1 from input"
    annotation(Dialog(tab = "General", group = "Surfaces"));

  parameter Boolean hasVariableAbsorptance_2 = false
    "Get absorptance abs for surface 2 from input"
    annotation(Dialog(tab = "General", group = "Surfaces"));

    // Variable longwave emissivity inputs
  Modelica.Blocks.Interfaces.RealInput epsilon_1_in(start=epsilon_1) if hasVariableEmissivity_1
    annotation (Placement(transformation(extent={{-40,-62},{-20,-42}}),
        iconTransformation(extent={{-40,-62},{-20,-42}})));

  Modelica.Blocks.Interfaces.RealInput epsilon_2_in(start=epsilon_2) if hasVariableEmissivity_2
    annotation (Placement(transformation(extent={{40,-62},{20,-42}}),
        iconTransformation(extent={{40,-62},{20,-42}})));

  // Variable shortwave absorptance inputs
  Modelica.Blocks.Interfaces.RealInput abs_1_in(start=abs_1) if hasVariableAbsorptance_1
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}}),
        iconTransformation(extent={{-40,-80},{-20,-60}})));

  Modelica.Blocks.Interfaces.RealInput abs_2_in(start=abs_2) if hasVariableAbsorptance_2
    annotation (Placement(transformation(extent={{40,-80},{20,-60}}),
        iconTransformation(extent={{40,-80},{20,-60}})));


  BuildingSystems.Interfaces.HeatPort heatPort_source if heatSource
    annotation (Placement(transformation(extent={{10,-40},{30,-20}}),
      iconTransformation(extent={{10,-40},{30,-20}})));

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
    annotation (Placement(transformation(extent={{-40,-104},{-20,-84}}),
        iconTransformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-82})));

protected
  Modelica.Blocks.Interfaces.RealInput epsilon_1_internal;
  Modelica.Blocks.Interfaces.RealInput epsilon_2_internal;
  Modelica.Blocks.Interfaces.RealInput abs_1_internal;
  Modelica.Blocks.Interfaces.RealInput abs_2_internal;

equation

  // Connect emissivity either to input or to parameter, depending on boolean
  if hasVariableEmissivity_1 then
    connect(epsilon_1_in,epsilon_1_internal);
  else
    epsilon_1_internal = epsilon_1;
  end if;

  if hasVariableEmissivity_2 then
    connect(epsilon_2_in,epsilon_2_internal);
  else
    epsilon_2_internal = epsilon_2;
  end if;

  // Connect sw absorptance either to input or to parameter, depending on boolean
  if hasVariableAbsorptance_1 then
    connect(abs_1_in,abs_1_internal);
  else
    abs_1_internal = abs_1;
  end if;

  if hasVariableAbsorptance_2 then
    connect(abs_2_in,abs_2_internal);
  else
    abs_2_internal = abs_2;
  end if;

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
     Line(points={{-30,-94},{-12,-94},{-12,-4.7},{-8.3,-4.7}}, color={0,0,127}));

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
