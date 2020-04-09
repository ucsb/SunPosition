% SUNPOSITION
% Functions
%   EarthEphemeris - Returns the solar declination, Earth-Sun radius vector
%       (distance in astronomical units), solar longitude, and optionally the
%       equation of time.
%   sunang - Returns cosine of sun angle, its azimuth (0 south, + east),
%       and airmass (path length accounting for Earth curvature). Optionally
%       accounts for refraction.
%   sunRiseSet - Times of sunrise and sunset.
%   sunslope - Cosine of illumination angle on slope
%
%About Orientation for Azimuths for sun angles and slopes
%   Years ago when I started coding for solar geometry in mountains, my go-to
%   text was William Sellers’ Physical Climatology (1965). Based on his conventions,
%   I adopted 0° toward South, positive to the East and negative to the West,
%   putting North at ±180°. This convention is consistent with a right-hand
%   coordinate system, which we normally use by making latitude positive to
%   the North and longitude positive to the East.
%   I realize that another common convention puts 0° toward North, and other
%   directions clockwise from North. Perhaps had I realized how common this
%   convention would be, I might have adopted it, but I didn’t, so the conversion
%   between directions in MATLAB and other data or analysis packages is that my
%   azimuths are 180 minus the clockwise-from-North azimuths.
%   Note that you can modify my sunang.m code to return azimuths clockwise from
%   north, and the sunslope.m code will work the same if the slope azimuth is
%   also from north.
