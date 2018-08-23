within BuildingSystems.Climate.WeatherDataMeteonorm;
block England_London_NetCDF
  extends BuildingSystems.Climate.WeatherData.BaseClasses.WeatherDataFileNetCDF(
  info="Source: Meteonorm 7.0",
  fileName=Modelica.Utilities.Files.loadResource("modelica://BuildingSystems/Climate/weather/WeatherDataNetcdf/England_London_weather.nc"))
  annotation(Documentation(info="<html>source: Meteonorm 7.0</html>"));
end England_London_NetCDF;