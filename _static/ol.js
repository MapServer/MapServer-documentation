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

function olmapinit(){
     
        map = new OpenLayers.Map( 'map' );

        var wms = new OpenLayers.Layer.WMS( "WMS","http://mapserver.org/geocache?",
        
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

        var osm_denver_osmgrid_tms_layer = new OpenLayers.Layer.TMS( "osm-denver-osmgrid-TMS",
        "http://demo.mapserver.org/geocache/tms",
        { layername: 'osm-denver@osmgrid', type: "png", serviceVersion:"1.0.0",
        gutter:0,buffer:0,isBaseLayer:true,transitionEffect:'resize',
        tileOrigin: new OpenLayers.LonLat(-109.060090,36.991292),
        resolutions:[0.31747799999999997134,0.15873899999999999011,0.07936999999999999389,0.03174799999999999844,0.01587399999999999878,0.00793699999999999939,0.00317499999999999982,0.00158800000000000008,0.00079699999999999989,0.00031699999999999999,0.00015899999999999999,0.00007899999999999999,0.00003200000000000000,0.00001600000000000000],
        units:"m",
        maxExtent: new OpenLayers.Bounds(-109.060090,36.991292,-102.043907,41.013656),
        projection: new OpenLayers.Projection("epsg:4326".toUpperCase()),
        sphericalMercator: false
     }
  );

        map.addLayers([osm_denver_osmgrid_tms_layer]);
        OpenLayers.IMAGE_RELOAD_ATTEMPTS = 3;
        if(!map.getCenter())
          map.setCenter(new OpenLayers.LonLat(lon, lat), zoom);
        var  controls = map.getControlsByClass('OpenLayers.Control.Navigation');
        for(var i = 0; i<controls.length; ++i)
          controls[i].disableZoomWheel();
}
OpenLayers.Event.observe(window, "load", olmapinit);

