function mu = sunslope( mu0,phi0,S,A )
% mu = sunslope( mu0,phi0,S,A )
%sunslope cosine of illumination angle on slope
%
% Input (angles in degrees)
%   mu0, cosine of sun angle on flat surface
%   phi0, sun azimuth, degrees, +ccw from south
%   S, slope angle, degrees, from horizontal
%   A, slope azimuth, degrees, +ccw from south
%
% Examples
%   Northern Hemisphere summer morning, Mt Blanc, NW and SE slopes
%   [declin,~,sol_lon] = EarthEphemeris(datetime('2020-07-04 10:00','TimeZone','Europe/Paris'))
%   [mu0,phi0] = sunang(45.8328,6.865,declin,sol_lon)
%   mu = sunslope(mu0,phi0,35,[-135 45])
%   Northern Hemisphere winter morning, Mt Blanc, NW and SE slopes
%   [declin,~,sol_lon] = EarthEphemeris(datetime('2020-01-04 10:00','TimeZone','Europe/Paris'))
%   [mu0,phi0] = sunang(45.8328,6.865,declin,sol_lon)
%   mu = sunslope(mu0,phi0,35,[-135 45])


[mu0,phi0,S,A] = checkSizes(mu0,phi0,S,A);
mu = mu0.*cosd(S) + sqrt((1-mu0).*(1+mu0)).*sind(S).*cosd(phi0-A);
if isscalar(mu) && mu<0
    mu = 0;
else
    t = mu<0;
    mu(t) = 0;
end

end