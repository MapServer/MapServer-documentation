var lon = -104.98903;
var lat = 39.761633;
var zoom = 8;
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

/*
function restrictExtent() {
        var re;
        return;
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
        }*/

function olmapinit(){
     
        map = new OpenLayers.Map( 'map' );
        
        var wms = new OpenLayers.Layer.WMS( "WMS","http://demo.mapserver.org:8081/geocache?",

        //var wms = new OpenLayers.Layer.WMS( "WMS","http://demo.mapserver.org/cgi-bin/foss4g?",
        {
        /*
        var wms = new OpenLayers.Layer.WMS( "WMS",

                "http://127.0.0.1:8081/cgi-bin/mapserv.exe?",
                {map: 'D:/ms4w/apps/osm/map/osm.map',*/


        layers: 'osm-denver',
        format: 'png',
        transparent: 'off'},
        {maxExtent: new OpenLayers.Bounds(-105.208290,39.542378,-104.769779,39.980889),
        scales: [5000,10000,25000,50000,100000,250000,500000,
                 1000000,2500000,5000000,10000000,25000000,50000000,100000000],
        units: 'dd',
        gutter:0,
        ratio:1,
        wrapDateLine: true,
        isBaselayer:true,
        transitionEffect:'resize'} );     

        map.addLayers([wms]);
        OpenLayers.IMAGE_RELOAD_ATTEMPTS = 3;
        if(!map.getCenter())
          map.setCenter(new OpenLayers.LonLat(lon, lat), zoom);
        var  controls = map.getControlsByClass('OpenLayers.Control.Navigation');
        for(var i = 0; i<controls.length; ++i)
          controls[i].disableZoomWheel();
}
OpenLayers.Event.observe(window, "load", olmapinit);

