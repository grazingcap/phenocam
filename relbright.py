#!/usr/bin/env python
# Jonah Duckles - jduckles@ou.edu
# Compute relative brightness of each color as it contributes to
#   the entire image

import sys
from PIL import Image
import numpy as np
import numpy.ma as ma
import json
import re
from datetime import datetime

masks = {'Marena': 204, 'Elreno': 123, ' Elreno_iGOS_East': 200,
            'Elreno_iCOS_East': 204 }

def relbright(fname, mask=True):
    pat = re.compile(r'[0-9]{4}-[0-9]{4}-[0-9]{6}')
    timestr = pat.findall(fname)[0]
    timeformat="%Y-%m%d-%H%M%S"
    isodate = datetime.strptime(timestr,timeformat).isoformat()
    keys = ['r','g','b']
    im = Image.open(fname)
    a = np.array(im.getdata())
    if mask:
        maskarray = simplemask(rows=204)
        a = ma.array(a, mask=maskarray)
    relbright = a.sum(axis=0)/float(a.sum())
    #return {'brightness': dict(zip(keys,relbright))}
    r, g, b = relbright
    return '%s,%s,%s,%s' % (fname,r,g,b)

def simplemask(width=1296,height=960,rows=None):
    ''' Mask the top # of rows from a phenocam image.
            Default settings apply no mask.
    '''
    mask = np.ones((height,width))
    if rows:
        mask[0:rows+1] = 0
        return np.array((mask,mask,mask))
    else:
        return np.array((mask,mask,mask))

if __name__ == '__main__':
    fname = sys.argv[1]
    print relbright(fname)
