Orientation for azimuths, for sun angles and slopes

Years ago when I started coding for solar geometry in mountains, my go-to text was William Sellers’ Physical Climatology (1965). Based on his conventions, I adopted 0° toward South, positive to the East and negative to the West, putting North at ±180°.  This convention is consistent with a right-hand coordinate system, which we normally use by making latitude positive to the North and longitude positive to the East.

I realize that another common convention puts 0° toward North, and other directions clockwise from North. Perhaps had I realized how common this convention would be, I might have adopted it, but I didn’t, so the conversion between directions in MATLAB and other data or analysis packages is that my azimuths are 180 minus the clockwise-from-North azimuths.

Note that you can modify my sunang.m code to return azimuths clockwise from north, and the sunslope.m code will work the same if the slope azimuth is also from north.

Another note: With either convention, averaging azimuths (for example in reprojecting) encounters a discontinuity at North. The solution is to average the sines and cosines of the azimuths separately, and then use the atan2(mean(sines),mean(cosines)) function to produce a meaningful average. For example, if we have two azimuths, one 6° East of North and the other 4° West of North (i.e. in my system 184° and -186°, or 6° and 356° in the clockwise-from-North system), simply taking the numerical averages results in a value nearly South in both cases. But
atan2d(mean([sind(dir1) sind(dir2)]),mean([cosd(dir1) cosd(dir2)]))
produces the right result in both conventions.
