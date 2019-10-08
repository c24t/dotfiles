#!/usr/bin/env python
"""
Get the last 8 git branches visited in the current repo.
"""

import itertools as it
import sh
import sys



def uniq(ible):
    seen = set()
    for ii in ible:
        if ii not in seen:
            seen.add(ii)
            yield ii

def lastrev(n=1):
    return sh.git(['rev-parse', '--abbrev-ref', '@{{-{}}}'.format(n)])

def ilastrevs():
    for ii in it.count(1):
        try:
            rc = lastrev(ii)
            if rc.exit_code != 0:
                return
            rev = rc.stdout.decode().strip()
            # revs are sometimes empty?
            if rev:
                yield rev
        except Exception:
            return

def main(n=8):
    for rev in it.islice(uniq(ilastrevs()), n):
        print(rev)

if __name__ == '__main__':
    main()
