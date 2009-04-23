var lon = 16831422;
var lat = -4011708;
var zoom = 4;
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
restrictedExtent: new OpenLayers.Bounds(16770012,-4044490,16876903,-3980726),
controls:[new OpenLayers.Control.Navigation(),
new OpenLayers.Control.PanZoom()]
});
  
        var wms = new OpenLayers.Layer.TileCache( "Sydney", 
        ['http://mapserver-tile-1.osgeo.org/tilecache',
        'http://mapserver-tile-2.osgeo.org/tilecache'],
        'osm',
        {
          maxExtent: new OpenLayers.Bounds(-20000000,-20000000,20000000,20000000),
          scales: [10000,25000,50000,100000,250000,500000,1000000,2500000,5000000,10000000],
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

