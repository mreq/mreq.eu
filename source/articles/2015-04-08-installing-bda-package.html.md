---
title: Installing the bda R package on Ubuntu
slug: r-bda-package
category: ubuntu
tags: ubuntu, R
---

Installing the bda package in R fails by default on Ubuntu.

When trying to install **bda** R package on Ubuntu, you've probably been greeted by

```
...
/usr/bin/ld: cannot find -llapack
/usr/bin/ld: cannot find -lblas
collect2: error: ld returned 1 exit status
make: *** [bda.so] Error 1
ERROR: compilation failed for package ‘bda’
* removing ‘/home/petr/R/x86_64-pc-linux-gnu-library/3.1/bda’

The downloaded source packages are in
        ‘/tmp/RtmpKhOXn7/downloaded_packages’
Warning message:
In install.packages("bda") :
  installation of package ‘bda’ had non-zero exit status
```

That's caused by some missing libraries. To fix this, you need to install BLAS and LAPACK. On Ubuntu:

```shell_session
sudo apt-get install liblapack-dev
```

Afterwards, installation works like it should.
