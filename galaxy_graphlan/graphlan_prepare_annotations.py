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
#  Modification log:  2014/03/26  George Weingart
#
#  Added the root_dir parameter to be used in the command
#  Modification log:  2022/01/12  George Weingart 
#  Updated for python3
###############################################################################
import argparse
#from cStringIO import StringIO
from io import StringIO
import sys
import string
import time
import pyphlan.pyphlan as circlib
import os
from time import gmtime, strftime
from pprint import pprint


def read_params(args):
    global parser
    parser = argparse.ArgumentParser(description='Circlader Annotate Argparser')
    parser.add_argument('--input', action="store", dest='inputname')
    parser.add_argument('--output', action="store", dest='outputname')
    parser.add_argument('--selclades', action="store", dest='selclades', default="?", nargs='?')
    parser.add_argument('--clade_marker_size', action="store", type=float, default=0, dest='clade_marker_size', nargs='?')
    parser.add_argument('--clade_marker_color', action="store", dest='clade_marker_color', default="?", nargs='?')
    parser.add_argument('--clade_marker_edge_color', action="store", dest='clade_marker_edge_color', default="?", nargs='?')
    parser.add_argument('--annotation_background_color', action="store", dest='annotation_background_color', default="?", nargs='?')
    parser.add_argument('--annotation', action="store", dest='annotation', default="?", nargs='?')
    parser.add_argument('--annotation_label_clade_selector', action="store", dest='annotation_label_clade_selector', default="?", nargs='?')
    parser.add_argument('--clade_marker_shape', action="store", dest='clade_marker_shape', default="?", nargs='?')
    parser.add_argument('--clade_marker_edge_width', action="store", type=float, default=0, dest='clade_marker_edge_width', nargs='?')
    parser.add_argument('--annotation_font_size', action="store", type=int, default=1, dest='annotation_font_size', nargs='?')
    parser.add_argument('--annotation_background_edge_color', action="store", dest='annotation_background_edge_color', default="?", nargs='?')
    parser.add_argument('--output_annot_file', action="store", dest='output_annot_file', default="?", nargs="?")
    parser.add_argument('--ignore_branch_len', action="store", dest='ignore_branch_len', default="?", nargs="?")
    parser.add_argument('--total_plotted_degrees', action="store", dest='total_plotted_degrees', type=float, default=0, nargs="?")
    parser.add_argument('--start_rotation', action="store", dest='start_rotation', type=float, default=0, nargs="?")
    parser.add_argument('--clade_separation', action="store", dest='clade_separation', type=float, default=0, nargs="?")
    parser.add_argument('--branch_bracket_width', action="store", dest='branch_bracket_width', type=float, default=0, nargs="?")
    parser.add_argument('--branch_bracket_depth', action="store", dest='branch_bracket_depth', type=float, default=0, nargs="?")
    parser.add_argument('--annotation_background_width', action="store", dest='annotation_background_width', type=float, default=0, nargs="?")
    parser.add_argument('--annotation_background_alpha', action="store", dest='annotation_background_alpha', type=float, default=0, nargs="?")
    parser.add_argument('--annotation_background_separation', action="store", dest='annotation_background_separation', type=float, default=0, nargs="?")
    parser.add_argument('--annotation_background_offset', action="store", dest='annotation_background_offset', type=float, default=0, nargs="?")
    parser.add_argument('--annotation_legend_font_size', action="store", dest='annotation_legend_font_size', type=int, default=1, nargs="?")
    parser.add_argument('--branch_thickness', action="store", dest='branch_thickness', type=float, default=0, nargs="?")
    parser.add_argument('--branch_color', action="store", dest='branch_color', default="?", nargs="?")
    parser.add_argument('--branch_ancestor_clade_color', action="store", dest='branch_ancestor_clade_color', default="?", nargs="?")
    parser.add_argument('--label_font_strech', action="store", dest='label_font_strech', type=int, default=0, nargs="?")
    parser.add_argument('--annotation_abbreviation', action="store", dest='annotation_abbreviation', default="?", nargs='?')
    parser.add_argument('--taxo_sel', action="store", dest='taxo_sel', default="0", nargs='?')
    parser.add_argument('--root_dir', action="store", dest='root_dir', nargs='?')


#################################################################################
#     Print subroutine - prints passed variables to output dataset              #
#     Parameters:                                                               #
#     vfile:  The file to be written to                                         #
#     vclade: The clade selected by the user                                    #
#     varname: The input parameter name, for example: annotation_label          #
#     vartype:  The type of parameter passed:                                   #
#               FreeText, Integer,Float                                         #
#     varvalue: The value if the parameter passed                               #
#################################################################################
def print_line(vfile, vclade, varname, vartype, varvalue):
    CladeSelector = results.annotation_label_clade_selector
    if not vartype == "Integer" and not vartype == "Float":
        varvalue = str(varvalue)
        if varvalue.startswith('__pd__'):
            varvalue = "#" + varvalue[6:]

    if CladeSelector == "?":
        CladeSelector = ''

    if CladeSelector == "-":
        CladeSelector = '*'

    if vartype == "FreeText" and len(varvalue.strip()) > 0:
        OutputString = vclade + CladeSelector + "\t" + varname + "\t" + varvalue + "\n"
        OutFile.write(OutputString)

    if (vartype == "Integer" or vartype == "Float") and varvalue > 0:
        OutputString = vclade + CladeSelector + "\t" + varname + "\t" + str(varvalue) + "\n"
        OutFile.write(OutputString)

#################################################################################
#     Print Global subroutine - prints passed variables to output dataset       #
#     Parameters:                                                               #
#     vfile:  The file to be written to                                         #
#     varname: The input parameter name, for example: annotation_label          #
#     vartype:  The type of parameter passed:                                   #
#               FreeText, Integer,Float                                         #
#     varvalue: The value if the parameter passed                               #
#################################################################################


def print_global_line(vfile, varname, vartype, varvalue):
    if vartype == "FreeText" and len(varvalue) > 0:
        OutputString = "*" + "\t" + varname + "\t" + varvalue + "\n"
        OutFile.write(OutputString)
    #####if (vartype == "Integer" or vartype == "Float") and varvalue > 0:
    ##### Update by GW 20220113  added check for None to avoid exception
    if (vartype == "Integer" or vartype == "Float") and varvalue != None and varvalue > 0:
        OutputString = "*" + "\t" + varname + "\t" + str(varvalue) + "\n"
        OutFile.write(OutputString)


##################################################################################
#  Main Program                                                                  #
##################################################################################
args = read_params(sys.argv)
results = parser.parse_args()

ResultsAnnotationAbbreviation = results.annotation_abbreviation

clade_names_results = ()
FileTimeStamp = strftime("%Y%m%d%H%M%S", gmtime())
TempFileName = "/tmp/CircladerAnnotate" + FileTimeStamp
OutFile = open(TempFileName, "w")


##################################################################################
#  Printing Global Variables                                                     #
##################################################################################
IgnoreBranchLen = int(results.ignore_branch_len)
print_global_line(OutFile, "ignore_branch_len", "Integer", IgnoreBranchLen)
TotalRotation = results.total_plotted_degrees
if TotalRotation == 360:
    TotalRotation = 0
print_global_line(OutFile, "total_plotted_degrees", "Float", TotalRotation)
StartRotation = results.start_rotation
if StartRotation == 180:
    StartRotation = 0
print_global_line(OutFile, "start_rotation", "Float", StartRotation)
print_global_line(OutFile, "clade_separation", "Float", results.clade_separation)
SubBranchesAngleReduction = results.branch_bracket_width
if SubBranchesAngleReduction == 0.25:
    SubBranchesAngleReduction = 0
print_global_line(OutFile, "branch_bracket_width", "Float", SubBranchesAngleReduction)
SubBranchesOpeningPoint = results.branch_bracket_depth
if SubBranchesOpeningPoint == 1:
    SubBranchesOpeningPoint = 0
print_global_line(OutFile, "branch_bracket_depth", "Float", SubBranchesOpeningPoint)
AnnotationsWingsWidth = results.annotation_background_width
if AnnotationsWingsWidth == 0.1:
    AnnotationsWingsWidth = 0
print_global_line(OutFile, "annotation_background_width", "Float", AnnotationsWingsWidth)
AnnotationsWingsAlpha = results.annotation_background_alpha
if AnnotationsWingsAlpha == 0.2:
    AnnotationsWingsAlpha = 0
print_global_line(OutFile, "annotation_background_alpha", "Float", AnnotationsWingsAlpha)
AnnotationWingOffset = results.annotation_background_separation
if AnnotationWingOffset == 0.02:
    AnnotationWingOffset = 0
print_global_line(OutFile, "annotation_background_separation", "Float", AnnotationWingOffset)
AnnotationsExtOffset = results.annotation_background_offset
if AnnotationsExtOffset == 0.02:
    AnnotationsExtOffset = 0
print_global_line(OutFile, "annotation_background_offset", "Float", AnnotationsExtOffset)
AnnotationLegendFontSize = results.annotation_legend_font_size
if AnnotationLegendFontSize == 7:
    AnnotationLegendFontSize = 0
print_global_line(OutFile, "annotation_legend_font_size", "Integer", AnnotationLegendFontSize)
BranchLineWidth = results.branch_thickness
if BranchLineWidth == 0.75:
    BranchLineWidth = 0
print_global_line(OutFile, "branch_thickness", "Float", BranchLineWidth)
print_global_line(OutFile, "branch_color", "FreeText", results.branch_color)
print_global_line(OutFile, "branch_ancestor_clade_color", "FreeText", results.branch_ancestor_clade_color)
print_global_line(OutFile, "label_font_strech", "Integer", results.label_font_strech)


fname = results.inputname
vartaxosel = int(results.taxo_sel)

ct = circlib.PpaTree(fname)
clade_names_results = ct.get_clade_names(full_names=vartaxosel)
#clade_names_results = circlib.get_clade_names( fname, full_names = vartaxosel)
if clade_names_results[0] is None:
    del clade_names_results[0]

clade_names_results.reverse()
clade_names_results.append('*')
clade_names_results.reverse()

SelCladeNumbers = results.selclades.split(",")


if len(SelCladeNumbers) == 1 and SelCladeNumbers[0] == "None":
    SelCladeNumbers = []
    SelCladeNumbers.append('1')

SelectedClades = []
for i in SelCladeNumbers:
    j = int(i) - 1
    SelectedClades.append(clade_names_results[j])


for SelectedClade in SelectedClades:
    print_line(OutFile, SelectedClade, "annotation_background_color", "FreeText", results.annotation_background_color)
    print_line(OutFile, SelectedClade, "clade_marker_color", "FreeText", results.clade_marker_color)
    CladeSize = results.clade_marker_size
    if CladeSize == 20:
        CladeSize = 0
    print_line(OutFile, SelectedClade, "clade_marker_size", "Float", CladeSize)
    print_line(OutFile, SelectedClade, "clade_marker_edge_color", "FreeText", results.clade_marker_edge_color)
    if results.clade_marker_shape.strip():
        print_line(OutFile, SelectedClade, "clade_marker_shape", "FreeText", results.clade_marker_shape)
    CladeEdgeLineWidth = results.clade_marker_edge_width
    if CladeEdgeLineWidth == 0.5:
        CladeEdgeLineWidth = 0
    print_line(OutFile, SelectedClade, "clade_marker_edge_width", "Float", CladeEdgeLineWidth)
    LabelFontSize = results.annotation_font_size
    if LabelFontSize == 7:
        LabelFontSize = 0
    print_line(OutFile, SelectedClade, "annotation_font_size", "Integer", LabelFontSize)
    print_line(OutFile, SelectedClade, "annotation_background_edge_color", "FreeText", results.annotation_background_edge_color)
    abbreviation_annotation_field = ""
    try:
        if len(ResultsAnnotationAbbreviation) > 0:
            abbreviation_annotation_field = ResultsAnnotationAbbreviation + ":"
    except BaseException:
        pass
    annotation_field = abbreviation_annotation_field + results.annotation

    if not results.annotation:
        annotation_field = annotation_field.replace(":", "")

    print_line(OutFile, SelectedClade, "annotation", "FreeText", annotation_field)

OutFile.close()


my_cmd = os.path.join(results.root_dir, "tools", "graphlan", "graphlan_annotate.py")


# my_cmd="//usr/local/galaxy-dist/tools/graphlan/graphlan_annotate.py"
my_cmd = my_cmd + " " + results.inputname
my_cmd = my_cmd + " " + results.output_annot_file
my_cmd = my_cmd + " " + " --annot " + TempFileName
os.system(my_cmd)
delete_cmd = "rm " + TempFileName
os.system(delete_cmd)