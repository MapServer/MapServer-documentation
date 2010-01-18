
from os import path
from itertools import groupby
try:
    from sphinx.builders import Builder
except ImportError:
    from sphinx.builder import Builder
    
class CollectLabelsBuilder(Builder):
   """
   Collects all present explicit labels into a table.
   """
   name = 'labels'

   def init(self):
       pass

   def get_outdated_docs(self):
       return "table with all labels"

   def write(self, *ignored):
       labels = self.env.labels.items()
       labels.sort(key=lambda x: x[0])

       outfile = open(path.join(self.outdir, 'labels.txt'), 'w')
       outfile.write('.. table:: \:ref\: reference labels\n\n')
       outfile.write('\t============================   =============================================================================================\n')
       outfile.write('\t%s %s\n' % ('Label'.ljust(30), 'Title'))
       outfile.write('\t============================   =============================================================================================\n')

       unlabeled = ['genindex','search','modindex']
       for docname, items in groupby(labels, key=lambda x: x[1][0]):
           for label in items:
               if label[0] in unlabeled:
                   outfile.write("""\t%s :ref:`%s`\n""" % ((label[0].ljust(30)).encode("utf-8"), label[0].encode("utf-8")))
               else:
                   outfile.write("""\t%s :ref:`%s <%s>`\n""" %((label[0].ljust(30)).encode("utf-8"),(label[1][2]).encode("utf-8"),(label[0]).encode("utf-8")))

       outfile.write('\t============================   =============================================================================================\n')

       outfile.close()

   def finish(self):
       return


def setup(app):
   app.add_builder(CollectLabelsBuilder)
