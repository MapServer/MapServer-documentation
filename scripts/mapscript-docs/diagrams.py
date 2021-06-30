"""
Create MapServer class diagrams
"""

import os
import pydot

OUTPUT_FOLDER = r"../../en/mapscript/mapscript-api/images"
FONT = "Sans Serif"


def save_file(graph, fn):
    filename = "%s.png" % fn
    graph.write_png(filename)


def create_er_diagram(graph, class1, class2, rel1, rel2):

    blue = "#6b6bd188"  # the last 2 digits are for transparency 00 transparent up to hh
    white = "#fdfefd"
    green = "#33a33388"

    id1 = "1"
    graph.add_node(
        pydot.Node(
            id1,
            style="filled",
            fillcolor=green,
            label=class1,
            fontname=FONT,
            shape="polygon",
        )
    )

    id2 = "2"
    graph.add_node(
        pydot.Node(
            id2,
            style="filled",
            fillcolor=blue,
            label=class2,
            shape="polygon",
            fontname=FONT,
        )
    )

    # relationship
    rel_id = "rel"
    rel_label = "{}-{}".format(class1[0].upper(), class2[0].upper())

    graph.add_node(
        pydot.Node(
            rel_id,
            style="filled",
            fillcolor="lightgrey",
            label=rel_label,
            shape="diamond",
            fontname=FONT,
        )
    )
    graph.add_edge(pydot.Edge(id1, rel_id, label=rel1))  # ,
    graph.add_edge(pydot.Edge(rel_id, id2, label=rel2))  # ,


def main(output_folder):

    relationships = [
        ("classObj", "layerObj", "0..n", "1"),
        ("classObj", "styleObj", "1", "0..n"),
        ("classObj", "labelObj", "1", "0..n"),
        ("classObj", "hashTableObj", "1", "0..1"),
        ("labelCacheMemberObj", "labelCacheObj", "0..n", "1"),
        ("labelCacheObj", "labelCacheMemberObj", "1", "0..n"),
        ("labelCacheObj", "markerCacheMemberObj", "1", "0..n"),
        ("labelObj", "scalebarObj", "0..1", "1"),
        ("labelObj", "legendObj", "0..n", "1"),
        ("labelObj", "classObj", "0..n", "1"),
        ("layerObj", "mapObj", "0..n", "0..1"),
        ("layerObj", "classObj", "1", "0..n"),
        ("layerObj", "hashTableObj", "1", "1"),
        ("legendObj", "mapObj", "0..1", "1"),
        ("legendObj", "labelObj", "1", "1"),
        ("lineObj", "pointObj", "0..1", "1..n"),
        ("mapObj", "layerObj", "0..1", "0..n"),
        ("mapObj", "legendObj", "1", "0..1"),
        ("mapObj", "scalebarObj", "1", "0..1"),
        ("mapObj", "referenceMapObj", "1", "0..1"),
        ("mapObj", "outputFormatObj", "1", "1..n"),
        ("markerCacheMemberObj", "labelCacheObj", "0..n", "1"),
        ("outputFormatObj", "mapObj", "1..n", "1"),
        ("pointObj", "lineObj", "1..n", "0..1"),
        ("referenceMapObj", "mapObj", "0..1", "1"),
        ("scalebarObj", "mapObj", "0..1", "1"),
        ("scalebarObj", "labelObj", "1", "1"),
        ("shapeObj", "lineObj", "1", "1..n"),
        ("styleObj", "classObj", "0..n", "1"),
        ("symbolObj", "symbolSetObj", "0..n", "1"),
        ("symbolSetObj", "symbolObj", "1", "0..n"),
    ]

    for r in relationships:
        graph = pydot.Dot(graph_type="digraph", rankdir="LR")
        create_er_diagram(graph, *r)

        fn = os.path.join(output_folder, "{}_{}".format(r[0], r[1]))
        save_file(graph, fn)


if __name__ == "__main__":
    main(OUTPUT_FOLDER)
    print("Done!")
