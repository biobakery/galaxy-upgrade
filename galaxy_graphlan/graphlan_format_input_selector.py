#!/usr/bin/env python
import sys
import string
import time
import pyphlan.pyphlan as pyphlan


def red(st, l):
    if len(st) <= l:
        return st
    l1, l2 = l / 2, l / 2
    return st[:l1] + ".." + st[len(st) - l2:]


def get_cols(data, full_names):
    if data == "":
        return []
    max_len = 70
    fname = data.dataset.file_name
    full_names = bool(int(full_names))
    clade_names_results = pyphlan.PpaTree(fname).get_clade_names(full_names=full_names)

    if clade_names_results[0] is None or len(clade_names_results[0]) < 1:
        del clade_names_results[0]
    clade_names_results.reverse()
    clade_names_results.append('*ALL*')
    clade_names_results.reverse()
    opt = []
    rc = ''
    lines = []
    try:
        lines = [(red((rc + v.split()[0]), max_len), '%d' % (i + 1), False) for i, v in enumerate(clade_names_results) if v]
    except BaseException:
        l1 = '*ALL*'
        l2 = 1
        l3 = False
        MyList = [l1, l2, l3]
        lines.append(MyList)
    return opt + lines
