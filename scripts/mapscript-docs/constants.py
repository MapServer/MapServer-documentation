import mapscript
import os
import io
import inspect
import types

from collections import defaultdict

OUTPUT_FOLDER = r"../../en/mapscript/mapscript-api/constants"


def create_template(key, enums, outputfile):

    header = """.. _mapfile-constants-{}:

{}
{}

.. hlist::
   :columns: 3
    """
    tmpl = """
   * .. autodata:: mapscript.{}
        :annotation: {}
"""

    title = key.replace("-", " ").title()
    ref = key.replace("-", "")

    underline = "+" * len(title)

    with io.open(output_file, "w", newline="\n") as f:
        f.write(header.format(ref, title, underline))
        for v, e in sorted(enums):
            f.write(tmpl.format(e, v))


def create_index_file(output_folder, enum_files):

    output_file = os.path.join(output_folder, "index.rst")

    tmpl = ".. include:: constants/{}\n"

    with io.open(output_file, "w", newline="\n") as f:
        for ef in sorted(enum_files):
            f.write(tmpl.format(os.path.basename(ef)))


def match_group(enumerations, patterns, val, p):

    for k, matcher in patterns.items():
        if matcher and p.startswith(matcher):
            enumerations[k].append((val, p))
            return True

    return False


props = dir(mapscript)

# a list of constant prefixes used for grouping
patterns = {
    "measure-shape": "MS_SHP",
    "shapefile": "MS_SHAPEFILE",
    "error": "MS_SHP",
    "layer": "MS_LAYER_",
    "file": "MS_FILE_",
    "db-connection": "MS_DB_",
    "line-join": "MS_CJC_",
    "symbol": "MS_SYMBOL_",
    "image-mode": "MS_IMAGEMODE_",
    "join": "MS_JOIN_",
    "compop": "MS_COMPOP_",
    "render": "MS_RENDER_",
    "comparison": "MS_TOKEN_COMPARISON_",
    "function": "MS_TOKEN_FUNCTION_",
    "query-type": "MS_QUERY_",
    "geos": "MS_GEOS_",
    "transform": "MS_TRANSFORM_",
    "align": "MS_ALIGN_",
    "shape-type": "MS_SHAPE_",
    "label-binding": "MS_LABEL_BINDING_",
    "style-binding": "MS_STYLE_BINDING_",
    "token-binding": "MS_TOKEN_BINDING_",
    "token-literal": "MS_TOKEN_LITERAL_",
    "token-logical": "MS_TOKEN_LOGICAL_",
    "version": "MS_VERSION_",
    "parse": "MS_PARSE_TYPE",
    "dbf-fields": "FT",
    "projections": "wkp_",
}

constants = [p for p in props if isinstance(getattr(mapscript, p), int)]
enumerations = defaultdict(list)

for p in constants:
    val = getattr(mapscript, p)

    if not match_group(enumerations, patterns, val, p):

        if "DEBUGLEVEL" in p:
            enumerations["debug"].append((val, p))
        elif "ERR" in p or p in ["MS_NOTFOUND"]:
            if p not in ["MS_ERROR_LANGUAGE", "MS_NOOVERRIDE"]:
                enumerations["error"].append((val, p))

        elif p.endswith("_ALLOCSIZE") or p in [
            "MS_MAX_LABEL_PRIORITY",
            "MS_MAX_LABEL_FONTS",
            "MS_DEFAULT_LABEL_PRIORITY",
            "MS_LABEL_FORCE_GROUP",
            "MS_HASHSIZE",
            "MESSAGELENGTH",
            "ROUTINELENGTH",
            "MS_DEFAULT_CGI_PARAMS",
            "MS_POSITIONS_LENGTH",
            "MS_MAXPATTERNLENGTH",
            "SHX_BUFFER_PAGE",
        ]:
            enumerations["allocations"].append((val, p))

        elif p in ["MS_DONE", "MS_FAILURE", "MS_SUCCESS"]:
            enumerations["return-codes"].append((val, p))

        elif p in ["MS_HILITE", "MS_NORMAL", "MS_SELECTED"]:
            enumerations["query-mode"].append((val, p))

        elif p in [
            "MS_LABEL_PERPENDICULAR_OFFSET",
            "MS_LABEL_PERPENDICULAR_TOP_OFFSET",
        ]:
            enumerations["label-offset"].append((val, p))

        elif p in ["MS_STYLE_SINGLE_SIDED_OFFSET", "MS_STYLE_DOUBLE_SIDED_OFFSET"]:
            enumerations["style-offset"].append((val, p))

        elif p in ["MS_TRUETYPE", "MS_BITMAP"]:
            enumerations["font-type"].append((val, p))

        elif p in ["MS_GET_REQUEST", "MS_POST_REQUEST"]:
            enumerations["request-type"].append((val, p))

        elif p in ["MS_MULTIPLE", "MS_SINGLE"]:
            enumerations["query-type"].append((val, p))

        elif p in [
            "MS_FALSE",
            "MS_NO",
            "MS_OFF",
            "MS_ON",
            "MS_TRUE",
            "MS_YES",
            "MS_EMBED",
            "MS_DELETE",
            "MS_DEFAULT",
            "MS_UNKNOWN",
        ]:
            enumerations["logical-control"].append((val, p))

        elif p in [
            "MS_GRATICULE",
            "MS_INLINE",
            "MS_MYGIS",
            "MS_OGR",
            "MS_ORACLESPATIAL",
            "MS_POSTGIS",
            "MS_RASTER",
            "MS_SDE",
            "MS_SHAPEFILE",
            "MS_TILED_SHAPEFILE",
            "MS_WFS",
            "MS_WMS",
            "MS_MYSQL",
            "MS_PLUGIN",
            "MS_KERNELDENSITY",
            "MS_UNION",
            "MS_CONTOUR",
            "MS_UNUSED_1",
            "MS_UNUSED_2",
            "MS_UVRASTER",
            "MS_IDW",
        ]:
            enumerations["connection"].append((val, p))

        elif p in [
            "MS_GIANT",
            "MS_LARGE",
            "MS_MEDIUM",
            "MS_SMALL",
            "MS_TINY",
            "MS_POSTGIS",
        ]:
            enumerations["label-size"].append((val, p))

        elif p in [
            "MS_IMAGECACHESIZE",
            "MS_MAXSTYLELENGTH",
            "MS_MAXSYMBOLS",
            "MS_MAXVECTORPOINTS",
        ]:
            enumerations["limiters"].append((val, p))

        elif p in (
            "MS_DD",
            "MS_FEET",
            "MS_INCHES",
            "MS_METERS",
            "MS_MILES",
            "MS_NAUTICALMILES",
            "MS_PIXELS",
            "MS_KILOMETERS",
            "MS_PERCENTAGES",
            "MS_INHERIT",
        ):
            enumerations["units"].append((val, p))

        elif p in (
            "MS_UL",
            "MS_LR",
            "MS_UR",
            "MS_LL",
            "MS_CR",
            "MS_CL",
            "MS_UC",
            "MS_LC",
            "MS_CC",
            "MS_AUTO",
            "MS_XY",
            "MS_NONE",
            "MS_AUTO2",
            "MS_FOLLOW",
        ):
            enumerations["position"].append((val, p))

        elif p in (
            "MS_ALL_MATCHING_CLASSES",
            "MS_FIRST_MATCHING_CLASS",
        ):
            enumerations["render-mode"].append((val, p))

        else:
            enumerations["missing"].append((val, p))

output_files = []
for k, v in enumerations.items():
    filename = k.replace("-", "")
    output_file = os.path.join(OUTPUT_FOLDER, "{}.rst".format(filename))
    create_template(k, v, output_file)
    output_files.append(output_file)

create_index_file(OUTPUT_FOLDER, output_files)

if len(enumerations["missing"]) > 0:
    print(
        "The following constants have not been categorised. {} remaining:".format(
            len(enumerations["missing"])
        )
    )

    for v, e in sorted(
        enumerations["missing"], key=lambda x: x[1]
    ):  # sort by name rather than value
        print(f"    {v} {e}")
