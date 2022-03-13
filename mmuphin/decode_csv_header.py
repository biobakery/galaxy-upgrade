import sys
import string
import csv
    #############################################################
    #   Progran to read the first row of the metadata
    #   and generate a text file from them
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


IFile = sys.argv[1]
OFileName = sys.argv[2]
lMetadata_Column_Names =  get_cols(IFile)
OFile = open(OFileName, "w")
for element in lMetadata_Column_Names:
    sOutRec = element + "\n"
    OFile.write(sOutRec)
OFile.close()
sys.exit(0)
