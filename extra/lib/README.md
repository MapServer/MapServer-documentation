# OpenLayers library files for template=openlayers

MapServer's built-in [OpenLayers viewer](https://mapserver.org/cgi/openlayers.html)
points to a hardcoded filepath of `www.mapserver.org/lib` to find the OpenLayers 
library, referred to in [maptemplate.c](https://github.com/MapServer/MapServer/blob/main/src/maptemplate.c#L54).

The entire contents of the `lib` folder in this documentation repository 
will now be copied as-is, when the documentation is built & deployed.

Previously, the `lib` folder containing the OpenLayers library only existed on 
a server (that could be pruned through various possible steps during the 
automatic deployment of the MapServer documentation).

# Related 

- [RFC 63](https://mapserver.org/development/rfc/ms-rfc-63.html) (add 
  Built-in OpenLayers map viewer)
- initial [issue #3549](https://github.com/MapServer/MapServer/issues/3549)

# History

- updated to OpenLayers 10.4.0 on 2025-02-09
- updated to OpenLayers 2.10 in 2014
- initially included in the MapServer 6.0 release in 2011
