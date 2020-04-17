# encoding: utf-8

from __future__ import print_function

# Example lines:
#
#   Parser [Oom.Instances]: alloc=814def from6056 time=19.425
#   Renamer/typechecker [Oom.Instances]: alloc=1147773568 time=5259.215
#   Float out(FOS {Lam = Just 0, Consts = True, OverSatApps = False}) [Oom.Instances]: alloc=496072088 time=6487.263
#   Demand analysis [Oom.Instances]: alloc=2205820872 time=5326.790

import os
import sys
import re
import contextlib

def parseLabeled(keyValue):
    _key, value = keyValue.split('=')
    return value

parens = re.compile('\([^)]+\)')

def parseLine(line):
    noParens = parens.sub('', line)
    components = noParens.split()
    stageComponents = []
    for i, component in enumerate(components):
        if component.startswith('['):
            break
        stageComponents.append(component)
    stage = ' '.join(stageComponents)
    alloc, time = components[i + 1:]
    return stage, int(parseLabeled(alloc)), float(parseLabeled(time))

def toSeconds(ms):
    return round(ms / 1000.0, 3)

def asSeconds(ms):
    return '{}s'.format(toSeconds(ms))

def toMbs(bs):
    return round(bs / 1024.0 / 1024.0, 3)

def asMbs(bs):
    return '{} MB'.format(toMbs(bs))

def asDiffSeconds(ms):
    seconds = toSeconds(ms)
    return '+{}s'.format(seconds) if ms > 0 else str(seconds)

def asDiffMbs(bs):
    mbs = toMbs(bs)
    return '+{} MB'.format(mbs) if bs > 0 else str(mbs)

def byDiffTime(measurement):
    return measurement['diffTime']

def byDiffAlloc(measurement):
    return measurement['diffAlloc']

def process(filename):
    lines = []
    with open(filename) as f:
        lines = [line.strip() for line in f]

    seen = {}
    stages = []
    for line in lines:
        name, alloc, time = parseLine(line)
        if name in seen:
            n = seen[name]
        else:
            n = 1
        seen[name] = n + 1
        name = '{} {}'.format(name, n)
        stages.append(dict(name=name, alloc=alloc, time=time))

    return stages

def compare(noDerivingVia, derivingVia):
    rows = []
    derivingViaMap = {
        stage['name']: stage for stage in derivingVia
    }

    noDerivingViaMap = {
        stage['name']: stage for stage in noDerivingVia
    }

    for old in noDerivingVia:
        name = old['name']
        if name in derivingViaMap:
            new = derivingViaMap[name]
            rows.append(dict(
                name=name,
                oldTime=old['time'],
                newTime=new['time'],
                diffTime=new['time'] - old['time'],
                oldAlloc=old['alloc'],
                newAlloc=new['alloc'],
                diffAlloc=new['alloc'] - old['alloc']
            ))
        else:
            rows.append(dict(
                name=name,
                oldTime=old['time'],
                newTime=None,
                diff=None,
                oldAlloc=old['alloc'],
                newAlloc=None,
                diffAlloc=None
            ))

    for new in derivingVia:
        name = new['name']
        if name not in noDerivingViaMap:
            raise Exception('Extra stage {!r} when using -XDerivingVia'.format(name))

    return rows

def findTimingsFile(workdir):
    for root, _, filenames in os.walk(workdir):
        for filename in filenames:
            if filename == 'Instances.dump-timings':
                return os.path.join(root, filename)

def table(**kwargs):
    rows = kwargs.pop('rows')
    widths = {}
    ordered = [
        key for (key, _)
        in sorted(kwargs.items(), key=lambda (key, value): value.order)
    ]

    formatted = []
    for row in rows:
        newRow = {}
        for key in kwargs:
            newRow[key] = kwargs[key].format(row[key])
        formatted.append(newRow)

    for key in kwargs:
        value = kwargs[key]
        widths[key] = max(
            len(text) for text in
            [value.label] + [row[key] for row in formatted]
        )

    formatString = '| ' + ' | '.join(
        '{{:<{}}}'.format(widths[key])
        for key in ordered
    ) + ' |'

    divider = '| ' + ' | '.join(
        '{{:-<{}}}'.format(widths[key])
        for key in ordered
    ) + ' |'

    labels = [kwargs[key].label for key in ordered]
    print(formatString.format(*labels))
    print(divider.format(*['' for _ in ordered]))
    for row in formatted:
        cells = [row[key] for key in ordered]
        print(formatString.format(*cells))

@contextlib.contextmanager
def section(title):
    print('{}\n'.format(title))
    yield
    print('')

class col(object):
    def __init__(self, label, order, format=None):
        self.label = label
        self.order = order
        self.format = (lambda x: str(x)) if format is None else format

if __name__ == '__main__':
    args = sys.argv[1:]
    if len(args) != 2:
        print('python gen.py no-deriving-via-work-dir deriving-via-work-dir')
        sys.exit(2)

    noDerivingViaWorkDir, derivingViaWorkDir = args
    noDerivingViaTimings = process(findTimingsFile(noDerivingViaWorkDir))
    derivingViaTimings = process(findTimingsFile(derivingViaWorkDir))

    rows = compare(noDerivingViaTimings, derivingViaTimings)

    with section('## Time'):
        table(
            name=col('Stage', order=1),
            oldTime=col('-XNoDerivingVia Time', order=2, format=asSeconds),
            newTime=col('-XDerivingVia Time', order=3, format=asSeconds),
            diffTime=col('Diff', order=4, format=asDiffSeconds),
            rows=rows
        )

    with section('## Time, sorted by diff'):
        table(
            name=col('Stage', order=1),
            oldTime=col('-XNoDerivingVia Time', order=2, format=asSeconds),
            newTime=col('-XDerivingVia Time', order=3, format=asSeconds),
            diffTime=col('Diff', order=4, format=asDiffSeconds),
            rows=sorted(rows, key=byDiffTime, reverse=True)
        )

    with section('## Allocation'):
        table(
            name=col('Stage', order=1),
            oldAlloc=col('-XNoDerivingVia Allocation', order=2, format=asMbs),
            newAlloc=col('-XDerivingVia Allocation', order=3, format=asMbs),
            diffAlloc=col('Diff', order=4, format=asDiffMbs),
            rows=rows
        )

    with section('## Allocation, sorted by diff'):
        table(
            name=col('Stage', order=1),
            oldAlloc=col('-XNoDerivingVia Allocation', order=2, format=asMbs),
            newAlloc=col('-XDerivingVia Allocation', order=3, format=asMbs),
            diffAlloc=col('Diff', order=4, format=asDiffMbs),
            rows=sorted(rows, key=byDiffAlloc, reverse=True)
        )
