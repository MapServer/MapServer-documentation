# -*- coding: utf-8 -*-
#
# MapServer documentation build configuration file, created by
# sphinx-quickstart on Fri Nov 21 09:49:43 2008.
#
# This file is execfile()d with the current directory set to its containing dir.
#
# The contents of this file are pickled, so don't put values in the namespace
# that aren't pickleable (module imports are okay, they're removed automatically).
#
# All configuration values have a default; values that are commented out
# serve to show the default.

import sys, os, shutil
import inspect
from unittest.mock import MagicMock #py3 only


# see https://docs.readthedocs.io/en/stable/faq.html#i-get-import-errors-on-libraries-that-depend-on-c-modules
class Mock(MagicMock):
    @classmethod
    def __getattr__(cls, name):
        mm = MagicMock()
        if name.startswith("MS_"):
            # don't document enums - we handle these separately
            mm.__doc__ = ""
        else:
            # add a TODO for any methods/properties missing docstrings
            mm.__doc__ = "**TODO** Add documentation"

        return mm
        
MOCK_MODULES = ['mapscript._mapscript']
sys.modules.update((mod_name, Mock()) for mod_name in MOCK_MODULES)


import mapscript

# If your extensions are in another directory, add it here. If the directory
# is relative to the documentation root, use os.path.abspath to make it
# absolute, like shown here.
sys.path.append(os.path.abspath('.'))

# General configuration
# ---------------------

# Add any Sphinx extension module names here, as strings. They can be extensions
# coming with Sphinx (named 'sphinx.ext.*') or your custom ones.
#extensions = ['labels' ,'rst2pdf.pdfbuilder']
#extensions = ['labels', 'sphinxcontrib.spelling']

extensions = ['labels', 'sphinx.ext.autodoc', 'sphinx.ext.autosummary', 'sphinx.ext.viewcode'
              , 'sphinxcontrib.jquery', 'sphinx_copybutton']

autosummary_generate = True # when True create a page for each mapscript class

autodoc_default_options = {
    "autosummary_imported_members": True
}

autoclass_content = 'class'
# new in Sphinx version 4.1 - hide erroneous warnings for mapscript generated references
nitpick_ignore_regex = [('py:obj', 'mapscript.*'), ('py:class', '.*'), 
                        ('py:data', '.*'), ('py:func', '.*'), ('py:attr', '.*')]


# Add any paths that contain templates here, relative to this directory.

templates_path = ['_templates', 'mapscript/mapscript-api/templates'] # en is automatically added

# The suffix of source filenames.

source_suffix = {
    '.rst': 'restructuredtext',
    '.txt': 'restructuredtext'
}    


# The encoding of source files.
source_encoding = 'utf-8'

# The master toctree document.
master_doc = 'index'

# General information about the project.
project = u'MapServer'

copyright = u'2025, Open Source Geospatial Foundation'

# The version info for the project you're documenting, acts as replacement for
# |version| and |release|, also used in various other places throughout the
# built documents.
#
# The short X.Y version.
version = '8.4'
# The full version, including alpha/beta/rc tags.
release = '8.4.0'
# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#language = None

# There are two options for replacing |today|: either, you set today to some
# non-false value, then it is used:
#today = ''
# Else, today_fmt is used as the format for a strftime call.
today_fmt = '%Y-%m-%d'

# The reST default role (used for this markup: `text`) to use for all documents.
#default_role = None

# If true, '()' will be appended to :func: etc. cross-reference text.
#add_function_parentheses = True

# If true, the current module name will be prepended to all description
# unit titles (such as .. function::).
#add_module_names = True

# If true, sectionauthor and moduleauthor directives will be shown in the
# output. They are ignored by default.
show_authors = True

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'sphinx'

# Exclude git directories
exclude_patterns = ['.git', 'howto', 'redirection', 'users-manual', 'mapscript/mapscript-api/constants', 'mapscript/mapscript-api/mapscript']

# check for broken reference targets
nitpicky = True

# Options for HTML output
# -----------------------

# The style sheet to use for HTML and HTML Help pages. A file of that name
# must exist either in Sphinx' static/ path, or in one of the custom paths
# given in html_static_path.
html_style = 'sphinx.css'

# The name for this set of Sphinx documents.  If None, it defaults to
# "<project> v<release> documentation".
html_title = "MapServer " + release + " documentation"

# A shorter title for the navigation bar.  Default is the same as html_title.
html_short_title = "Home"

# The name of an image file (relative to this directory) to place at the top
# of the sidebar.
#html_logo = None

# The name of an image file (within the static path) to use as favicon of the
# docs.  This file should be a Windows icon file (.ico) being 16x16 or 32x32
# pixels large.
html_favicon = "_static/mapserver.ico"

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

# If not '', a 'Last updated on:' timestamp is inserted at every page bottom,
# using the given strftime format.
html_last_updated_fmt = '%Y-%m-%d'

html_css_files = [
    'custom.css',
    'ribbon.css'
]

# If true, SmartyPants will be used to convert quotes and dashes to
# typographically correct entities.
html_use_smartypants = True

# Custom sidebar templates, maps document names to template names.
html_sidebars = {
    '**': ['sourcelink.html', 'searchbox.html', 'sidebar2.html', 'localtoc2.html'],
"index":['searchbox.html', "indexsidebar.html"]}
# Additional templates that should be rendered to pages, maps page names to
# template names.
#html_additional_pages = {"index":'index.html'}

# If false, no module index is generated.
#html_use_modindex = True

# If false, no index is generated.
#html_use_index = True

# If true, the index is split into individual pages for each letter.
#html_split_index = False

# If true, the reST sources are included in the HTML build as _sources/<name>.
html_copy_source = True

# If true, an OpenSearch description file will be output, and all pages will
# contain a <link> tag referring to it.  The value of this option must be the
# base URL from which the finished HTML is served.
#html_use_opensearch = ''

# If nonempty, this is the file name suffix for HTML files (e.g. ".xhtml").
html_file_suffix = '.html'

# Language to be used for generating the HTML full-text search index.
# Sphinx supports the following languages:
#   'da', 'de', 'en', 'es', 'fi', 'fr', 'h', 'it', 'ja'
#   'nl', 'no', 'pt', 'ro', 'r', 'sv', 'tr'
#html_search_language = 'en'

# A dictionary with options for the search language support, empty by default.
# Now only 'ja' uses this config value
#html_search_options = {'type': 'default'}

# The name of a javascript file (relative to the configuration directory) that
# implements a search results scorer. If empty, the default will be used.
#html_search_scorer = 'scorer.js'

# Output file base name for HTML help builder.
htmlhelp_basename = 'MapServerdoc'

# Hide source from sidebar (see https://www.sphinx-doc.org/en/1.8/usage/configuration.html#confval-html_show_sourcelink )
html_show_sourcelink = False

# Set the theme explicitly
html_theme = "classic"

# Add the branch name as a variable that can be used in templates
# this can be set as a sphinx-build option using `-A BRANCH=main`
html_context = {'branch': release}

# Options for LaTeX output
# ------------------------

#latex_engine = 'lualatex'

# The paper size ('letter' or 'a4').
#latex_paper_size = 'letter'

# The font size ('10pt', '11pt' or '12pt').
#latex_font_size = '10pt'

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title, author, document class [howto/manual]).
latex_documents = [
  ('documentation', 'MapServer.tex', u'MapServer Documentation',
   u'The MapServer Team', 'manual', False),
]

# The name of an image file (relative to this directory) to place at the top of
# the title page.
latex_logo = './_static/banner-large.png'

# For "manual" documents, if this is true, then toplevel headings are parts,
# not chapters.
latex_use_parts = False

latex_elements = {
# The paper size ('letter' or 'a4').
'papersize': 'letter',

# The font size ('10pt', '11pt' or '12pt').
#'pointsize': '10pt',

# necessary for unicode charactacters in pdf output
# especially the JP glyphs in the file /mapfile/encoding.txt
'inputenc': '',
'utf8extra': ('\\DeclareUnicodeCharacter{5730}{kanji1}\n'
              ' \\DeclareUnicodeCharacter{540D}{kanji2}\n'
             ),

# remove blank pages (between the title page and the TOC, etc.)
'classoptions': ',openany,oneside',
'babel' : '\\usepackage[english]{babel}',

# Additional stuff for the LaTeX preamble.
'preamble': r'''
  \usepackage{hyperref}
  \setcounter{tocdepth}{3} 
'''
}

# Documents to append as an appendix to all manuals.
#latex_appendices = []

# If false, no module index is generated.
latex_use_modindex = True
#

# -- Options for PDF output ---------------------------------------

    # Grouping the document tree into PDF files. List of tuples
    # (source start file, target name, title, author).
pdf_documents = [
    ('documentation', u'MapServer', u'MapServer Documentation', u'The MapServer Team'),
]

# A comma-separated list of custom stylesheets. Example:
pdf_stylesheets = ['sphinx','kerning','a4']

# Create a compressed PDF
# Use True/False or 1/0
# Example: compressed=True
#pdf_compressed=False

# A colon-separated list of folders to search for fonts. Example:
# pdf_font_path=['/usr/share/fonts', '/usr/share/texmf-dist/fonts/']

# Language to be used for hyphenation support
#pdf_language="en_EN"

# If false, no index is generated.
#pdf_use_index = True

# If false, no modindex is generated.
#pdf_use_modindex = True

# If false, no coverpage is generated.
#pdf_use_coverpage = True


# -- Options for Epub output ---------------------------------------------------

# Bibliographic Dublin Core info.
epub_title = 'MapServer Documentation'
epub_author = 'The MapServer Team'
epub_publisher = 'https://mapserver.org'
epub_copyright = copyright

# The language of the text. It defaults to the language option
# or en if the language is not set.
#epub_language = ''

# The scheme of the identifier. Typical schemes are ISBN or URL.
epub_scheme = 'URL'

# The unique identifier of the text. This can be a ISBN number
# or the project homepage.
epub_identifier = 'https://mapserver.org'

# A unique identification for the text.
#epub_uid = ''

# HTML files that should be inserted before the pages created by sphinx.
# The format is a list of tuples containing the path and title.
#epub_pre_files = []

# HTML files shat should be inserted after the pages created by sphinx.
# The format is a list of tuples containing the path and title.
#epub_post_files = []

# A list of files that should not be packed into the epub file.
#epub_exclude_files = []

# Path for sphinx to find *.mo files for translation
locale_dirs = ['../translated']

rst_epilog = """
.. |RUNSUB| replace:: This attribute can be replaced using runtime substitution. See :ref:`RUNSUB`.
.. role:: raw-html(raw)
   :format: html
.. |construction| replace:: :raw-html:`&#128679;`
.. |green-check-mark| replace:: :raw-html:`&#x2705;`
.. |red-cross-mark| replace:: :raw-html:`&#10060;`
.. |red-question-mark| replace:: :raw-html:`&#10067;`
"""

from pygments.lexer import RegexLexer, bygroups,combined, include
from pygments.token import *
from pygments import highlight
from pygments.formatters import HtmlFormatter


class WKTLexer(RegexLexer):
    name = 'wkt'
    aliases = ['wkt']
    filenames = ['*.wkt']

    tokens = {
        'root': [
            (r'\s+', Text),
            (r'[{}\[\]();,-.]+', Punctuation),
            (r'(PROJCS)\b', Generic.Heading),
            (r'(PARAMETER|PROJECTION|SPHEROID|DATUM|GEOGCS|AXIS)\b', Keyword),
            (r'(PRIMEM|UNIT|TOWGS84)\b', Keyword.Constant),
            (r'(AUTHORITY)\b', Name.Builtin),
            (r'[$a-zA-Z_][a-zA-Z0-9_]*', Name.Other),
            (r'[0-9][0-9]*\.[0-9]+([eE][0-9]+)?[fd]?', Number.Float),
            (r'0x[0-9a-fA-F]+', Number.Hex),
            (r'[0-9]+', Number.Integer),
            (r'"(\\\\|\\"|[^"])*"', String.Double),
            (r"'(\\\\|\\'|[^'])*'", String.Single)
        ]
    }

import re
builtins = (r'(ANNOTATION|'
            r'AUTO|BEVEL|BITMAP|BUTT|CARTOLINE|CC|CENTER|'
            r'CHART|CIRCLE|CL|CONTOUR|CR|CSV|'
            r'DEFAULT|DD|ELLIPSE|EMBED|FALSE|FEET|FOLLOW|'
            r'GIANT|HATCH|HILITE|IDW|INCHES|KERNELDENSITY|KILOMETERS|LARGE|LC|'
            r'LEFT|LINE|LL|LOCAL|LR|MEDIUM|METERS|MILES|MITER|MULTIPLE|MYGIS|MYSQL|NONE|'
            r'NORMAL|OFF|OGR|ON|ONE-TO-ONE|ONE-TO-MANY|ORACLESPATIAL|'
            r'PERCENTAGES|PIXMAP|PIXELS|POINT|POLYGON|POSTGIS|POSTGRESQL|'
            r'QUERY|RASTER|RIGHT|ROUND|SDE|SELECTED|SIMPLE|SINGLE|'
            r'SMALL|SQUARE|TINY|TRIANGLE|TRUE|TRUETYPE|UC|UL|UNION|UR|UV_ANGLE|UV_MINUS_ANGLE|UV_LENGTH|UV_LENGTH_2|UVRASTER|VECTOR|'
            r'WFS|WMS|ALPHA|'
            r'GIF|JPEG|JPG|PNG|WBMP|SWF|PDF|GTIFF|PC256|RGB|RGBA|INT16|FLOAT32|GD|'
            r'AGG|CAIRO|PNG8|SVG|KML|KMZ|GDAL|UTFGRID|MIXED'
            r')\b')

keywords = (r'(ALIGN|'
            r'ALPHACOLOR|ANCHORPOINT|ANGLE|ANTIALIAS|AUTHOR|BACKGROUNDCOLOR|BACKGROUNDSHADOWCOLOR|'
            r'BACKGROUNDSHADOWSIZE|BANDSITEM|BINDVALS|BROWSEFORMAT|BUFFER|CHARACTER|CLASS|CLASSITEM|'
            r'CLASSGROUP|CLUSTER|COLOR|COLORRANGE|COMPOSITE|COMPOP|COMPFILTER|CONFIG|'
            r'CONNECTION|CONNECTIONOPTIONS|CONNECTIONTYPE|DATA|DATAPATTERN|DATARANGE|DEBUG|'
            r'DRIVER|DUMP|EMPTY|ENCODING|END|ERROR|EXPRESSION|EXTENT|EXTENSION|FEATURE|'
            r'FILLED|FILTER|FILTERITEM|FOOTER|FONT|FONTSET|FORCE|FORMATOPTION|FROM|GAP|GEOMTRANSFORM|'
            r'GRID|GRIDSTEP|GRATICULE|GROUP|HEADER|IMAGE|IMAGECOLOR|IMAGETYPE|IMAGEQUALITY|IMAGEPATH|'
            r'IMAGEURL|INCLUDE|INDEX|INITIALGAP|INTERLACE|INTERVALS|JOIN|KEYIMAGE|KEYSIZE|KEYSPACING|LABEL|'
            r'LABELCACHE|LABELFORMAT|LABELITEM|LABELMAXSCALE|LABELMAXSCALEDENOM|'
            r'LABELMINSCALE|LABELMINSCALEDENOM|LABELREQUIRES|LATLON|LAYER|LEADER|LEGEND|'
            r'LEGENDFORMAT|LINECAP|LINEJOIN|LINEJOINMAXSIZE|LOG|MAP|MARKER|MARKERSIZE|'
            r'MASK|MAXARCS|MAXBOXSIZE|MAXDISTANCE|MAXFEATURES|MAXINTERVAL|MAXSCALE|MAXSCALEDENOM|MINSCALE|'
            r'MINSCALEDENOM|MAXGEOWIDTH|MAXLENGTH|MAXSIZE|MAXSUBDIVIDE|MAXTEMPLATE|'
            r'MAXWIDTH|METADATA|MIMETYPE|MINARCS|MINBOXSIZE|MINDISTANCE|'
            r'MINFEATURESIZE|MININTERVAL|MINSCALE|MINSCALEDENOM|MINGEOWIDTH'
            r'MINLENGTH|MINSIZE|MINSUBDIVIDE|MINTEMPLATE|MINWIDTH|NAME|OFFSET|OFFSITE|'
            r'OPACITY|OUTLINECOLOR|OUTLINEWIDTH|OUTPUTFORMAT|OVERLAYBACKGROUNDCOLOR|'
            r'OVERLAYCOLOR|OVERLAYMAXSIZE|OVERLAYMINSIZE|OVERLAYOUTLINECOLOR|'
            r'OVERLAYSIZE|OVERLAYSYMBOL|PARTIALS|PATTERN|PLUGIN|PLUGINS|POINTS|POLAROFFSET|POSITION|POSTLABELCACHE|'
            r'PRIORITY|PROCESSING|PROJECTION|QUERYFORMAT|QUERYMAP|RASTERLABEL|REFERENCE|REGION|'
            r'RELATIVETO|REQUIRES|RESOLUTION|SCALE|SCALEDENOM|SCALETOKEN|SHADOWCOLOR|SHADOWSIZE|'
            r'SHAPEPATH|SIZE|SIZEUNITS|STATUS|STYLE|STYLEITEM|SYMBOL|SYMBOLSCALE|'
            r'SYMBOLSCALEDENOM|SYMBOLSET|TABLE|TEMPLATE|TEMPLATEPATTERN|TEXT|'
            r'TILEINDEX|TILEITEM|TILESRS|TITLE|TO|TOLERANCE|TOLERANCEUNITS|TRANSPARENCY|'
            r'TRANSPARENT|TRANSFORM|TYPE|UNITS|UTFDATA|UTFITEM|WEB|WIDTH|WKT|WRAP|IMAGEMODE|VALIDATION|VALUES'
            r')\b')

class MapFileLexer(RegexLexer):
    name = 'mapfile'
    aliases = ['mapfile']
    filenames = ['*.map']

    flags = re.IGNORECASE
    tokens = {
        'root': [
            (r'\s+', Text),
            (r'\[.*?\]', Name.Other),
            (r'[{}\[\]();,-.]+', Punctuation),
            (r'#.*', Comment),
            (r'(AND|OR|NOT|EQ|GT|LT|GE|LE|NE|IN|IEQ)\b', Operator.Word),
            (r'!=|==|<=|>=|=~|&&|\|\||[-~+/*%=<>&^|./\$]', Operator),
            ('(?:[rR]|[uU][rR]|[rR][uU])"', String, 'dqs'),
            ("(?:[rR]|[uU][rR]|[rR][uU])'", String, 'sqs'),
            (r'`([^`])*`', Number.Date),
            ('[uU]?"', String, combined('stringescape', 'dqs')),
            ("[uU]?'", String, combined('stringescape', 'sqs')),
#            (constants, Keyword.Constant),
#            (r"""[]{}:(),;[]""", Punctuation),
            # (r'(MAP)\b', Generic.Heading),
            (keywords, Keyword),
            (builtins, Name.Builtin),
            (r'[0-9][0-9]*\.[0-9]+([eE][0-9]+)?[fd]?', Number.Float),
            (r'[0-9]+', Number.Integer)

        ],
        'dqs': [
            (r'"', String, '#pop'),
            (r'\\\\|\\"|\\\n', String.Escape), # included here again for raw strings
            include('strings')
        ],
        'sqs': [
            (r"'", String, '#pop'),
            (r"\\\\|\\'|\\\n", String.Escape), # included here again for raw strings
            include('strings')
        ],
        'tdqs': [
            (r'"""', String, '#pop'),
            include('strings'),
            include('nl')
        ],
        'tsqs': [
            (r"'''", String, '#pop'),
            include('strings'),
            include('nl')
        ],
        'strings': [
            (r'%(\([a-zA-Z0-9_]+\))?[-#0 +]*([0-9]+|[*])?(\.([0-9]+|[*]))?'
             '[hlL]?[diouxXeEfFgGcrs%]', String.Interpol),
            (r'[^\\\'"%\n]+', String),
            # quotes, percents and backslashes must be parsed one at a time
            (r'[\'"\\]', String),
            # unhandled string formatting sign
            (r'%', String)
            # newlines are an error (use "nl" state)
        ],
        'nl': [
            (r'\n', String)
        ],
        'stringescape': [
            (r'\\([\\abfnrtv"\']|\n|N{.*?}|u[a-fA-F0-9]{4}|'
             r'U[a-fA-F0-9]{8}|x[a-fA-F0-9]{2}|[0-7]{1,3})', String.Escape)
        ]
    }


def clean_variable(arg, convert_ref):
    """
    Strips whitespace and asterisks from variable names
    Adds mapscript. but will not make links
    """
    arg = arg.replace("*", "").strip()
    if convert_ref and arg[-3:] == "Obj":
        arg = arg.split(" ")[-1] # remove any struct etc.
        arg = ":class:`" + arg + "`"
    return arg



def clean_type_hints(obj, convert_ref=False):
    """
    Convert C typehints to mapscriptObj typehints
    """
    if hasattr(obj, "__annotations__"):
        clean = {}
        
        for k, v in obj.__annotations__.items():
            v = clean_variable(v, convert_ref)
            clean[k] = v
            
        setattr(obj, "__annotations__", clean)


def convert_mapscript_annotations(app, obj, bound_method):
    """
    Need these cleaned up before docstrings
    """
    clean_type_hints(obj)


def add_property_annotations(app, what, name, obj, options, lines):
    """
    For struct properties add the immutable flag, highlight the property
    name in bold, and clean variable names
    """
    if inspect.isclass(obj) == True and hasattr(obj, "__annotations__"):
        # for classes add property annotation to their doc strings
        if hasattr(obj, "__autodocupdated") == False:
            clean_type_hints(obj, convert_ref=True)

            # add to doc string for properties
            for name, v in vars(obj).items():
                if isinstance(v, property):
                    if name in obj.__annotations__:

                        if v.__doc__ is None:
                            setattr(v, "__doc__", "")
                            
                        # check for a setter to see if it is immutable
                        if v.fset is None:
                            immutable = "*immutable* "
                        else:
                            immutable = ""
                            
                        t = obj.__annotations__[name]
                        if ":class:" not in t:
                            t = "**{}**".format(t) # highlight the type in bold

                        v.__doc__ = "{} {}{}".format(t, immutable, v.__doc__)

            # only clean and update the docstrings once by setting a hidden flag
            obj.__autodocupdated = True


def setup(app):
    from sphinx.highlighting import lexers
    lexers['wkt'] = WKTLexer()
    lexers['mapfile'] = MapFileLexer()
    app.add_lexer('mapfile', MapFileLexer)
    app.connect('autodoc-before-process-signature', convert_mapscript_annotations)
    app.connect('autodoc-process-docstring', add_property_annotations)

    # copy the mapscript sourcecode so it can be used 
    # for doc examples with literalinclude
    dst_folder =  "./en/mapscript/mapscript-api/mapscript"
    if os.path.exists(dst_folder) == False:
        os.symlink(os.path.dirname(mapscript.__file__), dst_folder)

# avoid warnings of "nonlocal image URI found" (this parameter requires Sphinx >=1.4)
suppress_warnings = ['image.nonlocal_uri']
