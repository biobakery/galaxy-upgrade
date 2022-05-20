import os
import sys
import argparse
import pdb

#*************************************************************************************
#  Purpose of the program                                                            *
#  Check the size of an input file - if larger than athreshold: Issue Error RC       *
#                                                                                    *
#  The objective of the program is to check input files to our applications in       *
#      Galaxy.                                                                       *
#  If files are larger than a certain threshold,  we will not process the app        *
#                                                                                    *
#  Three parms                                                                       *
#      1.  The name of the input file                                                *
#      2.  The threshold: Usually 4Mb,  ie: If input file is greater than this       *
#           threshold,  we will not process it.                                      *
#      3.  The return code for error.  We chose arbitrarily 9, ie:                   *
#            if the file is smaller than the trheshold, rc=0, otherwise rc=threshold *
#                                                                                    *
#      Written by George Weingart  2022/05/20                                        *
#*************************************************************************************

###############################################################################################
#   Decode input parms                                                                        #
###############################################################################################
def read_params(x):
	CommonArea = dict()	
	parser = argparse.ArgumentParser(description='Check input file size and set up error code if larger than a threshold')
	
	parser.add_argument('-i',   '--InputFile' ,  
	   action = "store",
	   dest = 'InputFile',
	   nargs = '?',
	   help='Input File',
	   required = True )
	   
	parser.add_argument('-t',   '--Threshold' ,  
	   action = "store",
	   dest = 'Threshold',
	   nargs = '?',
	   help='Threshold size: Files greater than this threshold will trigger error return code',
	   required = False,
	   default = "4194304")

	parser.add_argument('-e',   '--Error_RC' ,  
	   action = "store",
	   dest = 'Error_RC',
	   nargs = '?',
	   help='Error return code if input file larger than threshold',
	   required = False,
	   default = "9")

	   
	
	CommonArea['parser'] = parser
	return  CommonArea

	
###############################################################################################
#   Program Start                                                                             #
###############################################################################################
CommonArea = read_params( sys.argv )   
parser = CommonArea['parser'] 
results = parser.parse_args()



Input_file = results.InputFile
Threshold = int(results.Threshold)
Error_RC = int(results.Error_RC)
rc = 0
file_size = os.path.getsize(Input_file)
if file_size > Threshold:
   rc = Error_RC
   print(Input_file, ":  File Size = ",file_size, "  exceeded threshold  of  : ", Threshold, "bytes -   Please run out of Galaxy" )
sys.exit(rc)

