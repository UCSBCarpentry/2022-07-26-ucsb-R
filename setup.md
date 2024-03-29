---
layout: page
title: Setup
---

## Setup instructions

**R** and **RStudio** are separate downloads and installations. R is the
underlying statistical computing environment, but using R alone is no
fun. RStudio is a graphical integrated development environment (IDE) that makes
using R much easier and more interactive. You need to install R before you
install RStudio. Once installed, because RStudio is an IDE, RStudio will run R in 
the background.  You do not need to run it separately. 

After installing both programs, 
you will need to install the **`tidyverse`** package from within RStudio. The 
**`tidyverse`** package is a powerful collection of data science tools within **R** 
see the [**`tidyverse`** website](https://tidyverse.tidyverse.org) for more details. 
Follow the instructions below for your operating system, and then follow the 
instructions to install **`tidyverse`**.

## Windows

#### If you already have R and RStudio installed

* Open RStudio, and click on "Help" > "Check for updates". If a new version is
	available, quit RStudio, and download the latest version for RStudio.
* To check which version of R you are using, start RStudio and the first thing
  that appears in the console indicates the version of R you are
  running. Alternatively, you can type `sessionInfo()`, which will also display
  which version of R you are running. Go on
  the [CRAN website](https://cran.r-project.org/bin/windows/base/) and check
  whether a more recent version is available. If so, you can update R using
  the `installr` package, by running:
  
~~~
if( !("installr" %in% installed.packages()) ){install.packages("installr")}
installr::updateR(TRUE)
~~~
{: .language-r}

#### If you don't have R and RStudio installed

* Download R from
  the [CRAN website](http://cran.r-project.org/bin/windows/base/release.htm).
* Run the `.exe` file that was just downloaded.
* Go to the [RStudio download page](https://www.rstudio.com/products/rstudio/download/#download).
* Under *Installers* select **RStudio x.yy.zzz - Windows.
  Vista/7/8/10** (where x, y, and z represent version numbers).
* Double click the file to install it.
* Once it's installed, open RStudio to make sure it works and you don't get any
  error messages.


## macOS

#### If you already have R and RStudio installed

* Open RStudio, and click on "Help" > "Check for updates". If a new version is
	available, quit RStudio, and download the latest version for RStudio.
* To check the version of R you are using, start RStudio and the first thing
  that appears on the terminal indicates the version of R you are running. Alternatively, you can type `sessionInfo()`, which will also display which version of R you are running. Go on
  the [CRAN website](https://cran.r-project.org/bin/macosx/) and check
  whether a more recent version is available. If so, please download and install
  it. In any case, make sure you have at least R 3.2.

#### If you don't have R and RStudio installed

* Download R from
  the [CRAN website](http://cran.r-project.org/bin/macosx/).
* Select the `.pkg` file for the latest R version.
* Double click on the downloaded file to install R.
* It is also a good idea to install [XQuartz](https://www.xquartz.org/) (needed
  by some packages).
* Go to the [RStudio download page](https://www.rstudio.com/products/rstudio/download/#download).
* Under *Installers* select **RStudio x.yy.zzz - Mac OS X 10.6+ (64-bit)**
  (where x, y, and z represent version numbers).
* Double click the file to install RStudio.
* Once it's installed, open RStudio to make sure it works and you don't get any
  error messages.


## Linux

* Follow the instructions for your distribution
  from [CRAN](https://cloud.r-project.org/bin/linux), they provide information
  to get the most recent version of R for common distributions. For most
  distributions, you could use your package manager (e.g., for Debian/Ubuntu run
  `sudo apt-get install r-base`, and for Fedora `sudo yum install R`), but we
  don't recommend this approach as the versions provided by this approach are
  usually out of date. In any case, make sure you have at least R 3.2.
* Go to the
  [RStudio download page](https://www.rstudio.com/products/rstudio/download/#download).
* Under *Installers* select the version that matches your distribution, and
  install it with your preferred method (e.g., with Debian/Ubuntu `sudo dpkg -i
  rstudio-x.yy.zzz-amd64.deb` at the terminal).
* Once it's installed, open RStudio to make sure it works and you don't get any
  error messages.
* Before installing the `tidyverse` package, **Ubuntu** (and related) users may
  need to install the following dependencies: `libcurl4-openssl-dev libssl-dev libxml2-dev`
  (e.g. `sudo apt install libcurl4-openssl-dev libssl-dev libxml2-dev`).

## Install required R packages and Data
During the course we will need a number of R packages. Packages contain useful R code written by other people. We will use the packages tidyverse, hexbin, patchwork, and RSQLite.

To try to install these packages, open RStudio and copy and paste the following command into the console window (look for a blinking cursor on the bottom left), then press the `Enter` (Windows and Linux) or `Return` (MacOS) to execute the command.

~~~
install.packages(c("tidyverse", "here", "hexbin", "patchwork", "RSQLite", "palmerpenguins"))
~~~
{: .language-r}

Alternatively, you can install the packages using RStudio’s graphical user interface by going to `Tools > Install Packages` and typing the names of the packages separated by a comma.

R tries to download and install the packages on your machine. When the installation has finished, you can try to load the packages by pasting the following code into the console:

~~~
library(tidyverse)
library(here)
library(hexbin)
library(patchwork)
library(RSQLite)
library(palmerpenguins)
~~~
{: .language-r}

If you do not see an error like `there is no package called ‘...’` you are good to go!

## Updating R packages

Generally, it is recommended to keep your R version and all packages up to date, because new versions bring improvements and important bugfixes. To update the packages that you have installed, click `Update` in the `Packages` tab in the bottom right panel of RStudio, or go to `Tools > Check for Package Updates....`

Sometimes, package updates introduce changes that break your old code, which can be very frustrating. To avoid this problem, you can use a package called renv. It locks the package versions you have used for a given project and makes it straightforward to reinstall those exact package version in a new environment, for example after updating your R version or on another computer. However, the details are outside of the scope of this lesson.

## Complications and Problems

If you find that you cannot download R/RStudio, you may instead use an image hosted by UCSB Letters and Science IT. You will be able to use R/Rstudio in your browser, so no installation is needed if you choose this option. If you wish to use the LSIT RStusio image, then you do not need to install anything. In the beginning of the workshop, we will provide you with the information you need to get RStudio running on your browser.


