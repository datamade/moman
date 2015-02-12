#!/usr/bin/env python

try:
    from setuptools import setup, Extension
except ImportError :
    raise ImportError("setuptools module required, please go to https://pypi.python.org/pypi/setuptools and follow the instructions for installing setuptools")

setup(name='Moman',
      version='0.2.1',
      description='A tools suite for orthographic/grammatical check',
      author='Jean-Philippe Barrette-LaPierre',
      author_email='jpb_NO_SPAM@rrette.com',
      ext_modules=[Extension('finenight.crecognize', ['src/crecognize.c'])],
      url='http://rrette.com/moman.html',
      packages=['finenight']
      )
