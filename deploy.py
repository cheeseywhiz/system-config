#!/usr/bin/env python3
import os
import shutil
import subprocess

HOME = os.getenv('HOME')


def make_sudo(cmd):
    if shutil.which('sudo'):
        return f'sudo {cmd}'
    else:
        return f'su -c "{cmd}"'


def shell(cmd, sudo=False, do_print=True, **kwargs):
    if sudo:
        cmd = make_sudo(cmd)

    print(cmd)
    proc = subprocess.run(
        cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
        **kwargs
    )

    if do_print and proc.stdout:
        print(proc.stdout.decode(), end='')

    if do_print and proc.stderr:
        print(proc.stderr.decode(), end='')

    return proc


def list_files():
    return shell('find ./* -mindepth 1 -type f '
                 '! -path "./var/*" '
                 '! -path "./__pycache__/*"'
                 ' | sed "s/^\\.\\///"',
                 do_print=False).stdout.decode().splitlines()


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
    destination = get_destination(path_in_repo)
    parent = os.path.dirname(destination)
    parent_stat = stat_existing_parent(destination)
    sudo = not parent_stat.st_uid

    if os.path.isdir(destination) and os.path.islink(destination):
        return

    if not os.path.exists(parent):
        shell(f'mkdir -p {parent}', sudo=sudo)

    shell(f'ln -svf {realpath} {destination}', sudo=sudo)


def main():
    for path_in_repo in list_files():
        deploy(path_in_repo)


if __name__ == '__main__':
    main()
