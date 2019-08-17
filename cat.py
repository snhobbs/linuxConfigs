from itertools import zip_longest
red = "\033[38;5;9m"
white = "\033[38;5;255m"
resetcolor = "\033[39m"
sLines = []
with open(".snoopy.txt", 'r') as f:
    for line in f:
        sLines.append(line.strip("\n"))

pLines  = []
with open("clplanes", 'r') as f:
    for line in f:
        pLines.append(line.strip("\n").format("{}+{}".format(red, resetcolor)))

ThoughtLines = 0
ThoughtLinesEnd = 7
DogHouseLine = 19
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

    print(color, s, resetcolor, " "*(maxlen - len(s) + 15), p)

