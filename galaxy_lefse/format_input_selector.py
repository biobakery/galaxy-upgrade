from galaxy import datatypes, model
import sys
import string
import time
    #############################################################
    #  Modified by George Weingart 2022/01/24                   #
    #  The program was failing in the red routine when          #
    #  l was odd and l/2 was fractional                         #
    #  so modified l1, l2 = l / 2, l / 2                 to:    #
    #     l1, l2 = int(l / 2), int(l / 2)                       #
    #############################################################


def timenow():
    """return current time as a string
    """
    return time.strftime('%d/%m/%Y %H:%M:%S', time.localtime(time.time()))


def get_opt(data):
    return [('r', 'r', False), ('c', 'c', False)]


def red(st, l):
    if len(st) <= l:
        return st
    #############################################################
    #  Modified by George Weingart 2022/01/24                   #
    #############################################################
    #l1, l2 = l / 2, l / 2
    l1, l2 = int(l / 2), int(l / 2)
    #############################################################
    #  End of modification by George Weingart                   #
    #############################################################
    return st[:l1] + ".." + st[len(st) - l2:]

def get_row_names(data,t):
    if data == "":
         return []
    max_len =38                 
    fname = data.dataset.file_name
    opt = []
    rc = ''
    if t == 'b':
         lines = [(red(v.split()[0],max_len),'%d' % (i+1),False) for i,v in enumerate(open(fname)) if len(v.split()) > 3 ] 
    else:
        lines = [(red(v.split()[0],max_len),'%d' % (i+1),False) for i,v in enumerate(open(fname))]
    return sorted(opt+lines)

def get_cols(data, t, c):
    if data == "":
        return []
    max_len = 32
    fname = data.dataset.file_name
    opt = []
    if c != 'cl':
        opt.append(('no ' + c, '%d' % -1, False))
    if t == 'c':
        rc = ''
        lines = [(red((rc + "#" + str(i + 1) + ":" + v[0]), max_len), '%d' % (i + 1), False) for i, v in enumerate(zip(*[line.split() for line in open(fname)]))]
    else:
        rc = ''
        lines = [(red((rc + "#" + str(i + 1) + ":" + v.split()[0]), max_len), '%d' % (i + 1), False) for i, v in enumerate(open(fname))]
    return opt + lines
