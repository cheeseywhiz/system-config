#!/bin/env python3
import collections
import os
import subprocess

HOME = os.getenv('HOME')


def shell(cmd, sudo=False, **kwargs):
    if sudo:
        cmd = f'sudo {cmd}'

    print(cmd)
    return subprocess.run(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, **kwargs)


def git_ls_files():
    return shell('git ls-files  **/').stdout.decode().splitlines()


def get_destination(path_in_repo):
    destination = f'/{path_in_repo}'

    if destination.startswith('/home'):
        destination = HOME + destination[len('/home'):]

    return destination


def gen_parents(path, strict=True):
    while True:
        if not strict:
            yield path

        path = os.path.dirname(path)

        if strict:
            yield path

        if path == '/':
            return


def stat_existing_parent(path):
    for parent in gen_parents(path):
        if os.path.exists(parent):
            return os.stat(parent)


def deploy(path_in_repo):
    realpath = os.path.realpath(path_in_repo)
    parent = os.path.dirname(realpath)
    destination = get_destination(path_in_repo)
    parent_stat = stat_existing_parent(destination)
    sudo = not parent_stat.st_uid

    if not os.path.exists(parent):
        shell(f'mkdir -p {parent}', sudo=sudo)

    shell(f'ln -sf {realpath} {destination}', sudo=sudo)


def main():
    for path_in_repo in git_ls_files():
        deploy(path_in_repo)


if __name__ == '__main__':
    main()
