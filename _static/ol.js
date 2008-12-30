var lon = 261330;
var lat = 6250266;
var zoom = 7;
var map;


OpenLayers.Control.PanZoom.prototype.draw = function(px) {
    // initialize our internal div
      OpenLayers.Control.prototype.draw.apply(this, arguments);
    px = this.position;

      // place the controls
      this.buttons = [];

      var sz = new OpenLayers.Size(18,18);
    var centered = new OpenLayers.Pixel(px.x+sz.w/2, px.y);

      this._addButton("panup", "north-mini.png", centered, sz);
    px.y = centered.y+sz.h;
    this._addButton("panleft", "west-mini.png", px, sz);
    this._addButton("panright", "east-mini.png", px.add(sz.w, 0), sz);
    this._addButton("pandown", "south-mini.png",
                        centered.add(0, sz.h*2), sz);
    this._addButton("zoomin", "zoom-plus-mini.png",
                        centered.add(0, sz.h*3.5+5), sz);
    this._addButton("zoomout", "zoom-minus-mini.png",
                        centered.add(0, sz.h*4.5+5), sz);
    return this.div;
};

function olmapinit(){
  map = new OpenLayers.Map( 'olmap', {
restrictedExtent: new OpenLayers.Bounds(243000,6236000,278000,6263000),
controls:[new OpenLayers.Control.Navigation(),
new OpenLayers.Control.PanZoom()]
});
  
        var wms = new OpenLayers.Layer.TileCache( "S3", 
        ['http://mapserver-tile-1.osgeo.org/tilecache',
        'http://mapserver-tile-2.osgeo.org/tilecache'],
        'parisosm',
        {
          maxExtent: new OpenLayers.Bounds(-571405,5067685,1061388,6637184),
          resolutions:[1763.8879363894034,881.9439681947017,352.7775872778807,176.38879363894034,88.19439681947017,35.27775872778806,17.63887936389403,8.819439681947015,3.527775872778806,1.763887936389403],
          units: 'm',
          projection:new OpenLayers.Projection("EPSG:900913"),
          buffer:0,
          isBaselayer:true
        } );

map.addLayers([wms]);
OpenLayers.IMAGE_RELOAD_ATTEMPTS = 3;
if(!map.getCenter())
  map.setCenter(new OpenLayers.LonLat(lon, lat), zoom);
}
OpenLayers.Event.observe(window, "load", olmapinit);

