import csv
import pandas as pd
baseReg = open("C:\\Users\\kranz.amber22\\Desktop\\outputReg.txt","w")
col_list=["Registry Time","Total Events","Opens","Closes","Reads","Writes","Other","Path"]
df = pd.read_csv("C:\\Users\\kranz.amber22\\Desktop\\reg2.csv",usecols=col_list)
print(df["Path"])
for row in csvreader:
    print(row)
with open('C:\\Users\\kranz.amber22\\Desktop\\test.txt') as f:
    lines = f.readlines()
    print(lines[6])
    currKey = "[HKEY_LOCAL_MACHINE\BCD00000000\Description]\n"
    ind = lines.index(currKey)
    baseReg.write(currKey)
    if(lines[ind+1][0] == '"'):
        cnt = 2
        while(not lines[ind+cnt][0] == '['):
            baseReg.write(lines[ind+cnt])
            cnt += 1
baseReg.close()
