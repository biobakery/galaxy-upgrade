from galaxy import datatypes, model
import sys
import string
import csv
import pdb
    #############################################################
    #   Progran to read the first row of the metadata
    #   and populate the fields in the panel 
    #   Written by George Weingart  2022/03/10
    #############################################################




 

def mmuphin_get_cols(data):
    pdb.set_trace()
    if data == "":
         return []
    fname = data.dataset.file_name
    lMetadata_Colnames = list() 
    f = open(fname)
    csv_reader = csv.reader(f)
    line_cntr = -1
    for line in csv_reader:
        line_cntr+=1
        if line_cntr > 0:
            return lMetadata_Colnames
        lMetadata_Colnames = [x for x in line if x]
    f.close()
    return lMetadata_Colnames



