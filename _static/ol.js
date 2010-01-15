var lon = 240750;
var lat = 5070290;
var zoom = 5;
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

function restrictExtent() {
        var re;
        //return;
        if(map.zoom >= 9) {
                re = new OpenLayers.Bounds(232128.90549511,5061987.4207997,251589.88109746,5081199.6882021);
                map.restrictedExtent = re;
            
        } else if (map.zoom >= 7) {
                re = new OpenLayers.Bounds(185699.84723398,4927656.4983161,366154.16113992,5191548.6526213);
                map.restrictedExtent = re;
        } else if (map.zoom >= 6) {
                re = new OpenLayers.Bounds(-13249.073112705,4734973.415064,649796.40217677,5391405.8401392);
                map.restrictedExtent = re;
        } else if (map.zoom >= 5) {
                re = new OpenLayers.Bounds(-350504.44654968,4397719.5711671,964297.62123439,5717725.108365);
                map.restrictedExtent = re;
        } else {
                re = new OpenLayers.Bounds(-1096452.6548487,4297707.1251797,935546.2478719,6675428.0634347);
                map.restrictedExtent = re;
        }
            if(!re.containsBounds(map.getExtent())) {
                map.panTo(new OpenLayers.LonLat(lon,lat));
            }
        }

function olmapinit(){
    map = new OpenLayers.Map( 'olmap', {eventListeners: {"zoomend": restrictExtent},
controls:[new OpenLayers.Control.Navigation(),
new OpenLayers.Control.PanZoom()]
});
  
        var wms = new OpenLayers.Layer.TileCache( "Barcelona", 
        ['http://mapserver-tile-1.osgeo.org/tilecache',
        'http://mapserver-tile-2.osgeo.org/tilecache'],
        'bcn',
        {
          maxExtent: new OpenLayers.Bounds(-20000000,-20000000,20000000,20000000),
          scales: [5000,10000,25000,50000,100000,250000,500000,1000000,2500000,5000000,10000000,25000000],
          units: 'm',
          projection:new OpenLayers.Projection("EPSG:900913"),
          buffer:0,
          isBaselayer:true
        } );

map.addLayers([wms]);
OpenLayers.IMAGE_RELOAD_ATTEMPTS = 3;
if(!map.getCenter())
  map.setCenter(new OpenLayers.LonLat(lon, lat), zoom);
var  controls = map.getControlsByClass('OpenLayers.Control.Navigation');
for(var i = 0; i<controls.length; ++i)
       controls[i].disableZoomWheel();
}
OpenLayers.Event.observe(window, "load", olmapinit);

