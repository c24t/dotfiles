#!/usr/bin/env python
import sys


def uniq(ible):
    seen = set()
    for item in ible:
        if item not in seen:
            seen.add(item)
            yield item


if __name__ == '__main__':
    for out in uniq(line.strip() for line in sys.stdin):
        print(out)
