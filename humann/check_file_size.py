import os
import sys
Input_file = sys.argv[1]
Threshold = int(sys.argv[2])
print(Threshold)
rc = 0
file_size = os.path.getsize(Input_file)
if file_size > Threshold:
   rc = 9
   print(Input_file, ":  File Size = ",file_size, "  exceeded threshold  of  : ", Threshold, "bytes -   Please run out of Galaxy" )
sys.exit(rc)

