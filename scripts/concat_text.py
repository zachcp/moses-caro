#!/usr/bin/env python

from subprocess import call

files = ["text/moses{}.txt".format(i+1) for i in range(23)]
command = "cat {} > mosesresponse.txt".format(" ".join(files))
call(command, shell=True)