from finenight import iadfa
from finenight import recognize
from finenight import fsc 
import csv
from collections import defaultdict

DISTANCE = 3

company_names = []

with open("company_names.csv") as f :
    reader = csv.reader(f) 
    reader.next()
    for i, row in enumerate(reader) :
        company_names.append(row[0])


sorted_names = [word for word in sorted(set(company_names)) if word]

index = iadfa.IncrementalAdfa()
for name in sorted_names :
    index.createFromSortedListOfWords(name)

index.initSearch()

transition_states = recognize.getTransitionStates("finenight/levenshtein.dat",
                                                  DISTANCE)

etr = fsc.ErrorTolerantRecognizer(DISTANCE, transition_states)

canopies = defaultdict(list)

for i, name in enumerate(company_names) :
    for near_name in etr.recognize(name, index) :
        canopies[near_name].append((i, name))

i = 0
for k, v in canopies.items() :
    if len(v) > 1 :
        i += 1
        print "%s, %s: %s" % (i, k, v)
        print

