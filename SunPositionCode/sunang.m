function [mu0, phi0, airmass] = sunang( lat, lon, declin, omega, varargin )
% [mu0, phi0, airmass] = sunang( lat, lon, declin, omega, ... )
%Sun angles on horizontal surface, with optional correction for refraction
%   (uses the distance function from the Mapping Toolbox)
%
%  Input (in degrees)
%   latitude
%   longitude
%   declin, solar declination
%   omega, longitude at which sun is vertical
%
%  Optional arguments that go after omega, in the following order:
%   zeroflag - if true, sets output negative cosines to zero and their
%       corresponding azimuths to NaN, default true
%       if false, returns negative cosines and their azimuths
%   (next optional arguments are a pair, supply neither or both)
%   P - pressure in hPa (same as mb), to correct for atmospheric path length and
%       refraction, default ignore refraction
%   T - temperature in Kelvin, to correct for atmospheric path length and
%   	refraction, default ignore refraction
%  Output:
%   mu0, cosine of solar zenith angle
%   phi0, solar azimuth (degrees, from south, + ccw)
%   airmass - relative atmospheric path length, where 1.0 is the path
%       length at solar zenith angle = 0

p = inputParser;
addRequired(p,'lat',@(x) isnumeric(x) && all(abs(x(:))<=90))
addRequired(p,'lon',@(x) isnumeric(x) && all(abs(x(:))<=180))
addRequired(p,'declin',@(x) isnumeric(x) && all(abs(x(:))<=23.6))
addRequired(p,'omega',@(x) isnumeric(x) && all(abs(x(:))<=180))
% default is to set negative cosines to zero
addOptional(p,'zeroflag',true,@(x) isnumeric(x) || islogical(x))
% default is to not account for refraction
addOptional(p,'P',[],@(x) isnumeric(x) && all(x(:)>0))
addOptional(p,'T',[],@(x) isnumeric(x) && all(x(:)>0))
parse(p,lat,lon,declin,omega,varargin{:});

assert(~xor(isempty(p.Results.P),isempty(p.Results.T)),...
    'if you specify pressure or temperature, you must specify both')

if ~isscalar(lat)
    assert(isequal(size(lat),size(lon)),...
        'if not scalars, lat & lon must be same size')
    if ~isscalar(declin)
        assert(isequal(size(declin),size(omega),size(lat)),...
            'if not scalars, decline & omega must be same size as lat/lon')
    end
end

[arclen, phi0] = distance(lat, lon, declin, omega);
mu0 = cosd(arclen);
% translate so that 0 is south, positive counter-clockwise
phi0 = 180-phi0;

% atmospheric refraction
if ~isempty(p.Results.P)
    mu0 = refracted(mu0, p.Results.P, p.Results.T);
end

% relative airmass
airmass = kasten(mu0);

% set negative cosines to zero
if p.Results.zeroflag
    t = mu0 < 0;
    if nnz(t)
        mu0(t) = 0;
        phi0(t) = NaN;
    end
end

end