# SunPosition
For Earth, computes solar declination, radius vector, equation of time, and sun angles on horizontal or sloping surfaces.
Uses the MATLAB datetime data type so the user does not have to worry about conversions between local times and UTC.
Examples are provided as MATLAB Live Functions, which can be run and in which code can be examined.

Code is best installed using the .mltbx file, with is also available from the MATLAB File Exchange:
https://www.mathworks.com/matlabcentral/fileexchange/74939-sun-position

EarthEphemeris - declination, radius vector, solar longitude, and equation of time as functions of date and time, based on the NOAA Solar Calculator http://www.esrl.noaa.gov/gmd/grad/solcalc/
sunang - Sun angle (its cosine), azimuth, and relative air mass (Kasten & Young, 1989) on horizontal surface as function of latitude, longitude, declination, and solar longitude, with optional correction for refraction (Reda & Andreas, 2008).
sunslope - cosine of illumination angle on a slope.
sunRiseSet - times of sunrise and sunset, as MATLAB datetimes.
NOTE ABOUT AZIMUTHS FOR SUN ANGLES AND SLOPES: Years ago when I started coding for solar geometry in mountains, my go-to text was William Sellers’ Physical Climatology (1965). Based on his conventions, I adopted 0° toward South, positive to the East and negative to the West, putting North at ±180°. This convention is consistent with a right-hand coordinate system, which we normally use by making latitude positive to the North and longitude positive to the East. I realize that another common convention puts 0° toward North, and other directions clockwise from North, i.e. a left-hand system. Perhaps had I realized how common this convention would be, I might have adopted it, but I didn’t, so the conversion between directions in MATLAB and other data or analysis packages is that my azimuths are 180 minus the clockwise-from-North azimuths. You can modify my sunang.m code to return azimuths clockwise from north, and the sunslope.m code will work the same if the slope azimuth is also from north.
With either convention, averaging azimuths (for example in reprojecting) encounters a discontinuity at North. The solution is to average the sines and cosines of the azimuths separately, and then use the atan2(mean(sines),mean(cosines)) function to produce a meaningful average. For example, if we have two azimuths, one 6° East of North and the other 4° West of North (i.e. in my system 184° and -186°, or 6° and 356° in the clockwise-from-North system), simply taking the numerical averages results in a value nearly South in both cases. But atan2d(mean([sind(dir1) sind(dir2)]),mean([cosd(dir1) cosd(dir2)])) produces the right result in both conventions.
Kasten, F., & Young, A. T. (1989). Revised optical air mass tables and approximation formula. Applied Optics, 28, 4735-4738. https://doi.org/10.1364/AO.28.004735
Reda, I., & Andreas, A. (2008). Solar position algorithm for solar radiation applications (revised) (NREL/TP-560-34302. Golden, CO: National Renewable Energy Laboratory. https://doi.org/10.2172/15003974
Sellers, W. D. (1965). Physical Climatology. Chicago: University of Chicago Press.
