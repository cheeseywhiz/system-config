#!/usr/bin/env python3
# TODO: sort an already sorted folder by skipping directories that conform to the 2022-01-Jan format
import datetime
import glob
import os
import shlex
import sys
from collections import defaultdict
from pprint import pprint as pp

DRY = True
STOP_LIST = {
    '.*',
    'Photo Booth Library',
    'Photos Library.photoslibrary',
}


def get_stop_list():
    stop_list = []
    for filename in STOP_LIST:
        stop_list.extend(glob.glob(filename))
    return stop_list


def run(*args):
    cmd = shlex.join(args)
    print(cmd)
    if DRY:
        return
    if os.system(cmd) != 0:
        raise RuntimeError


def main(dirname):
    os.chdir(dirname)
    stop_list = get_stop_list()
    moves = defaultdict(set)

    for filename in os.listdir():
        if filename in stop_list:
            continue

        stat = os.stat(filename)
        date = datetime.datetime.fromtimestamp(stat.st_ctime)
        folder = date.strftime('%Y-%m-%b')  # 2022-01-Jan
        moves[folder].add(filename)

    for folder, filenames in sorted(moves.items()):
        run('mkdir', '-p', folder)
        run('mv', *sorted(filenames), folder)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        raise RuntimeError('must provide dirname')
    main(sys.argv[1].rstrip('/'))
