import sys
import string
import csv
import pdb
    #############################################################
    #   Progran to read the first row of the metadata
    #   and populate the fields in the panel 
    #   Written by George Weingart  2022/03/10
    #############################################################


 

def get_cols(data):
    if data == "":
         return []
    lMetadata_Colnames = list() 
    f = open(data)
    csv_reader = csv.reader(f)
    line_cntr = -1
    for line in csv_reader:
        line_cntr+=1
        if line_cntr > 0:
            return lMetadata_Colnames
        lMetadata_Colnames = [x for x in line if x]
    f.close()
    return lMetadata_Colnames


pdb.set_trace()
print("Program started")
IFile = sys.argv[1]
OFile = sys.argv[2]
lMetadata_Column_Names =  get_cols(IFile)
sys.exit(0)
