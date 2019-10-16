within BuildingSystems.Buildings.Constructions.Shadowing.Functions;
function overhang
  "Calculates the shadowing coefficent of an overhang"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Length height
    "Height of the opening";
  input Modelica.SIunits.Length heightOH
    "Height of the overhang";
  input Modelica.SIunits.Length depthOH
    "Depth of the overhang";
  input Modelica.SIunits.Conversions.NonSIunits.Angle_deg angleDegAzi
    "Azimuth angle of the embrasure: south: 0 deg, east: -90 deg, west +90 deg, north: 180 deg";
  input Modelica.SIunits.Conversions.NonSIunits.Angle_deg angleDegAziSun
    "Azimuth angle of the sun: south: 0 deg, east: -90 deg, west +90 deg, north: 180 deg";
  input Modelica.SIunits.Conversions.NonSIunits.Angle_deg angleDegHeightSun
    "Height angle of the sun";
  output Real SC
    "Shading coefficient";
algorithm
  SC := min(1.0,max(0.0,(heightOH+height)/height*(1.0 - depthOH/(heightOH+height)
       * Modelica.Math.tan(Modelica.Constants.pi/180.0*angleDegHeightSun)/Modelica.Math.cos(Modelica.Constants.pi/180.0*(angleDegAziSun - angleDegAzi)))
       * (0.5 + 0.5*Modelica.Math.tanh(10000.0*angleDegHeightSun))));
  annotation (
Documentation(info="<html>
<p>
This is a model of an overhang.
</p>
</html>", revisions="<html>
<ul>
<li>
October 10, 2019 by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
end overhang;
