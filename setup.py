#!/usr/bin/env python

try:
    from setuptools import setup, Extension
except ImportError :
    raise ImportError("setuptools module required, please go to https://pypi.python.org/pypi/setuptools and follow the instructions for installing setuptools")

setup(name='finenight',
      version='0.1',
      description="hacked on version of JPBL, moman library",
      author='Jean-Philippe Barrette-LaPierre, Forest Gregg',
      author_email='fgregg@gmail.com',
      ext_modules=[Extension('finenight.crecognize', ['src/crecognize.c'])],
      url='https://github.com/datamade/moman',
      packages=['finenight']
      )
