within BuildingSystems.Climate.WeatherDataDWD;
block Germany_Potsdam2018_DWD_NetCDF
  extends BuildingSystems.Climate.WeatherData.BaseClasses.WeatherDataFileNetCDF(
  info="Source: DWD",
  fileName=Modelica.Utilities.Files.loadResource("modelica://BuildingSystems/Climate/weather/Germany_Potsdam_2018_DWD.nc"))
  annotation(Documentation(info="<html>source: Deutscher Wetterdienst</html>"));
end Germany_Potsdam2018_DWD_NetCDF;
