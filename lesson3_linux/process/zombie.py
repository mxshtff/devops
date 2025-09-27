#! /bin/python
import os, time
import sys

# for zombie process set ttlForParent > ttlForChild
ttlForParent = 20
ttlForChild = 40
childProcessCount = 5

print("Hello! I'm PARENT process")
for i in range(0,childProcessCount):
    pid = os.fork()
    if pid == 0:
        print(f"\tI'm CHILD process {i}")
        for j in range(1,ttlForChild):
            print(f'\t{j} sec\tProcess {i} - MMMrrrrr')
            time.sleep(1)
        print(f"I'm CHILD {i}. Bye!")
        sys.exit(0)

for i in range(1,ttlForParent):
    print(f'{i} sec\tParent process - HHHrrrrr')
    time.sleep(1)
print("I'm PARENT. Bye!")
sys.exit(0)