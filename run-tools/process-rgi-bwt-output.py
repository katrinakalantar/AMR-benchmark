import pandas as pd
import sys

df = pd.read_csv(sys.argv[1], sep='\t')

# override the %ID with the maximum
pid = df['Reference Allele(s) Identity to CARD Reference Protein (%)']
updated_pid = [max([float(i.split()[0]), float(i.split()[-1])]) for i in pid]
df['Reference Allele(s) Identity to CARD Reference Protein (%)'] = updated_pid

# override the Ref Length with the maximum
reflen = df['Reference Length']
updated_len = [max([int(j) for j in i.split(';')]) for i in reflen]
df['Reference Length'] = updated_len

df.to_csv(sys.argv[1]+'.pidmod', sep='\t', index=False)
