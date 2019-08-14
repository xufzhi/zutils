#!/usr/bin/env python

# usage: rename-to-md5.py FILES
# desc:  calculate md5 of a file and rename it using md5 digest.
# note:  filename contains .git will be ignored.

import os
import sys
import hashlib
from os import path

KB=1024
MB=1024*KB

def calc_md5(fname):
    md5 = hashlib.md5()
    with open(fname, 'rb') as f:
        for chunk in iter(lambda: f.read(MB), b''):
            md5.update(chunk)
    return md5.hexdigest()

def should_skip(fname):
    if not path.isfile(fname):
        return True
    for sp in ['.git']:
        if sp in fname:
            return True
    return False

def rename_md5(fname, md5):
    dst = md5
    if '.' in fname:
        arr = fname.rsplit('.', 1)
        dst = md5 + '.' + arr[1]
    print('rename {:40} to {}'.format(fname, dst))
    os.rename(fname, dst)

if __name__ == '__main__':
    for fname in sys.argv[1:]:
        if should_skip(fname):
            print('skiped {}'.format(fname))
            continue
        md5 = calc_md5(fname)
        if md5 in fname:
            continue
        rename_md5(fname, md5)
