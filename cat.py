from itertools import zip_longest
red = "\033[38;5;9m"
white = "\033[38;5;255m"
resetcolor = "\033[39m"
yellow = "\033[255;255;0m"
orange = "\033[255;215;0m"

sLines = []
with open(".snoopy.txt", 'r') as f:
    for line in f:
        sLines.append(line.strip("\n"))

pLines  = []
with open("clplanes_burning", 'r') as f:
    for line in f:
        pline = line.strip("\n")
        pline = pline.format("{}+{}".format(red, resetcolor))
        pline = pline.replace("<", "{}<{}".format(orange, resetcolor)) 
        pLines.append(pline)

ThoughtLines = 0
ThoughtLinesEnd = 7
DogHouseLine = 19
PlanePadding = 3
maxlen = max([len(s) for s in sLines])
i = 0
for s, p in (zip_longest(sLines, pLines)):
    i+=1
    if s is None:
        s = ""
    if p is None:
        p = ""

    color = resetcolor
    if(i > DogHouseLine):
        color = red

    if(i < ThoughtLinesEnd):
        color = white

    print(color, s, resetcolor, " "*(maxlen - len(s) + PlanePadding), p)

