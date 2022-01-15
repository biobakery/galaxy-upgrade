#!/usr/bin/env python
###############################################################################
#
# NAME: circlader_prepare_annotations.py
# DESCRIPTION: Prepares annotations from input parameters
#               builds annotation file 
#
# Author:   George Weingart
#
#
#  Modification log:  2022/01/12  George Weingart 
#  Updated for python3
###############################################################################
import argparse
#from cStringIO import StringIO
from io import StringIO
import sys,string,time
import pyphlan.pyphlan as circlib
import os
from time import gmtime, strftime
from pprint import pprint

def read_params(args):
	global parser
	parser = argparse.ArgumentParser(description='Circlader Annotate Argparser')
	parser.add_argument('--input', action="store",dest='inputname')
	parser.add_argument('--annot', action="store",dest='annot')
	parser.add_argument('--output_annot_file', action="store",dest='output_annot_file')
	parser.add_argument('--root_dir', action="store", dest='root_dir',nargs='?')


##################################################################################
#  Main Program                                                                  #
##################################################################################
args = read_params( sys.argv )
results = parser.parse_args()


my_cmd= os.path.join(results.root_dir,"tools","graphlan","graphlan_annotate.py")

######my_cmd="//usr/local/galaxy-dist/tools/graphlan/graphlan_annotate.py" 
my_cmd += " " + " --annot " + results.annot
my_cmd += " " + results.inputname
my_cmd += " " + results.output_annot_file 
os.system(my_cmd)
#with open("/tmp/p","w") as outf:
#    outf.write(my_cmd + "\n")

#delete_cmd = "rm " + TempFileName
#os.system(delete_cmd)