" Vim syntax file
" Language:     map (umn mapserver config file)
" Maintainer:   Andreas Hirner <andreas.hirner@dlr.de>
" Maintainer:   Thomas Bonfort
" Last Change:  $Date: 2009/04/10$
" Filenames:    *.map
" Note:         The definitions below are taken from TextPad syntax definitions (*.syn) by Chris Thorne (thorne@dmsolutions.ca) as of May 2004, for version 4.0 MapServer

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Always ignore case
syn case ignore

" General keywords first order
syn keyword mapDefine       CLASS END JOIN LABEL LAYER LEGEND MAP METADATA OUTPUTFORMAT
syn keyword mapDefine       PROJECTION QUERYMAP REFERENCE SCALEBAR STYLE SYMBOL WEB

" General keywords second order
syn keyword mapIdentifier   ALIGN ALPHACOLOR ANGLE ANTIALIAS
syn keyword mapIdentifier   BACKGROUNDCOLOR BACKGROUNDSHADOWCOLOR BACKGROUNDSHADOWSIZE BUFFER
syn keyword mapIdentifier   CENTER CHARACTER CLASSITEM COLOR CONFIG CONNECTION CONNECTIONTYPE
syn keyword mapIdentifier   DATA DATAPATTERN DEBUG DRIVER DUMP
syn keyword mapIdentifier   EMPTY ENCODING ERROR EXPRESSION EXTENSION EXTENT
syn keyword mapIdentifier   FEATURE FILLED FILTER FILTERITEM FONT FONTSET FOOTER FORCE FORMATOPTION FROM
syn keyword mapIdentifier   GAP GEOMTRANSFORM GRATICULE GRID GROUP HEADER
syn keyword mapIdentifier   IMAGE IMAGECOLOR IMAGEMODE IMAGEPATH IMAGEQUALITY IMAGETYPE IMAGEURL INDEX INTERLACE INTERVALS
syn keyword mapIdentifier   KEYIMAGE KEYSIZE KEYSPACING
syn keyword mapIdentifier   LABELCACHE_MAP_EDGE_BUFFER LABELANGLEITEM LABELCACHE LABELFORMAT LABELITEM LABELMAXSCALEDENOM LABELMINSCALEDENOM LABELREQUIRES LABELSIZEITEM LATLON LINECAP LINEJOIN LINEJOINMAXSIZE LOG
syn keyword mapIdentifier   MARKER MARKERSIZE MAXARCS MAXBOXSIZE MAXFEATURES MAXINTERVAL MAXLENGTH MAXSCALEDENOM MAXSIZE MAXSUBDIVIDE MAXTEMPLATE MAXWIDTH MIMETYPE
syn keyword mapIdentifier   MINARCS MINBOXSIZE MINDISTANCE MINFEATURESIZE MININTERVAL MINSCALEDENOM MINSIZE MINSUBDIVIDE MINTEMPLATE MINWIDTH
syn keyword mapIdentifier   NAME
syn keyword mapIdentifier   OFFSET OFFSITE OPACITY OUTLINECOLOR OUTLINEWIDTH OVERLAYBACKGROUNDCOLOR OVERLAYCOLOR OVERLAYMAXSIZE OVERLAYMINSIZE OVERLAYOUTLINECOLOR OVERLAYSIZE OVERLAYSYMBOL
syn keyword mapIdentifier   PARTIALS PATTERN POINTS POSITION POSTLABELCACHE PRIORITY PROCESSING
syn keyword mapIdentifier   REQUIRES RESOLUTION
syn keyword mapIdentifier   SCALE SHADOWCOLOR SHADOWSIZE SHAPEPATH SIZE SIZEUNITS STATUS STYLEITEM SYMBOLSCALEDENOM SYMBOLSET
syn keyword mapIdentifier   TABLE TEMPLATE TEMPLATEPATTERN TEXT TILEINDEX TILEITEM TITLE TO TOLERANCE TOLERANCEUNITS TRANSFORM TRANSPARENCY TRANSPAREN[T] TYPE
syn keyword mapIdentifier   UNITS WIDTH WMS_ABSTRACT WMS_ACCESSCONSTRAINTS WMS_ONLINERESOURCE WMS_SRS WMS_TITLE WRAP

" General keywords third order
syn keyword mapKeyword      ANNOTATION AUTO BEVEL BITMAP BUTT
syn keyword mapKeyword      CARTOLINE CC CIRCLE CL CR CSV DD DEFAULT
syn keyword mapKeyword      ELLIPSE EMBED FALSE FEET FOLLOW GIANT HILITE INCHES
syn keyword mapKeyword      KILOMETERS LARGE LC LINE LL LR
syn keyword mapKeyword      MEDIUM METERS MILES MITER MULTIPLE MYGIS NORMAL
syn keyword mapKeyword      OFF OGR ON ONE-TO-MANY ONE-TO-ONE ORACLESPATIAL
syn keyword mapKeyword      PIXELS PIXMAP POINT POLYGON POSTGIS QUERY RASTER ROUND
syn keyword mapKeyword      RGB RGBA SDE SELECTED SIMPLE SINGLE SMALL SQUARE
syn keyword mapKeyword      TINY TRIANGLE TRUE TRUETYPE UC UL UR VECTOR WFS WMS

" keywords for other purposes
syn keyword mapTypedef      SELECTION

" Comment
syn match mapComment      "#.*"

" Strings (single- and double-quote)
syn region mapString       start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region mapString       start=+'+  skip=+\\\\\|\\'+  end=+'+

" Numbers and hexidecimal values
syn match mapNumber         "-\=\<[0-9]*\>"
syn match mapNumber         "\<0x[abcdefABCDEF0-9]*\>"

" Operators
syn match mapOperator      "EQ"
syn match mapOperator      "[><|\=&!$/\\()\[\]]"


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_map_syn_inits")
  if version < 508
    let did_map_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink mapComment      Comment
  HiLink mapKeyword      Keyword
  HiLink mapIdentifier   Identifier
  HiLink mapDefine      Define
  HiLink mapTypedef      Typedef
  HiLink mapNumber      Number
  HiLink mapString      String
  HiLink mapOperator   Operator

  delcommand HiLink
endif

let b:current_syntax = "map"

" vim: ts=8
