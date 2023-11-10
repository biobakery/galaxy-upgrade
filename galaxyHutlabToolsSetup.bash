!# /bin/bash

#  Download the upgrade library here 
git clone https://github.com/biobakery/galaxy-upgrade.git  /galaxy-central/tools
# metaphlan install
sudo apt-get update
conda deactivate
. /galaxy_venv/bin/activate
sudo apt install build-essential
sudo apt-get install bowtie2
apt-get install less
apt-get install bsdmainutils
pip install MetaPhlAn==3.0.13
pip install humann==3.6
pip uninstall numpy
pip install numpy
metaphlan --install

#########################################################################
# If you want to reorder the applications order, you need to update     #
# the integrated_tools_panel.xml file with the order you want           #
# That file resides in /export/galaxy-central                           #
# There is a copy of that file in our git which I kept in the           #
# hutlab_tools directory (as of 7/18/2022)  GW.                         #
#########################################################################  


##########################################################################
#    maaslin2 install                                                    #
##########################################################################



sudo apt install apt-transport-https software-properties-common
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
sudo apt-get update
sudo apt install r-base
sudo apt install libssl-dev
sudo apt install libgit2-dev
sudo apt-get install libgmp3-dev libxml2-dev libfontconfig1-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev 
sudo apt-get install libmpfr-dev
sudo apt-get install ncbi-blast+

sudo apt install vim cmake
mkdir /galaxy-central/tools/maaslin
mkdir /galaxy-central/tools/maaslin/Maaslin2

R -q -e "install.packages('BiocManager')"
R -q -e "BiocManager::install(version = '3.10')"

git clone https://github.com/biobakery/Maaslin2.git  /galaxy-central/tools/maaslin/Maaslin2
R -q -e "install.packages(c('lmerTest','pbapply','car','dplyr','vegan','chemometrics','ggplot2','pheatmap','hash','logging','data.table','MuMIn','glmmTMB','MASS','cplm','pscl'), repos='http://cran.r-project.org')"
R -q -e "install.packages(c('optparse','logging','data.table', 'dplyr', 'hash', 'lme4', 'pbapply', 'lmerTest', 'pheatmap','devtools'), repos='http://cran.r-project.org')"
R -q -e "devtools::install_github('biobakery/SparseDOSSA2')"
##########################################################################
# For lefse
# ########################################################################
R -q -e "install.packages(c('modeltools','coin'), repos='http://cran.r-project.org')"

#panphlan install
mkdir /galaxy-central/tools/panphlan
mkdir /galaxy-central/tools/panphlan/panphlan
git clone https://github.com/SegataLab/panphlan.git /galaxy-central/tools/panphlan/panphlan
sudo apt-get install -y samtools

##########################################################################
# Please add the statements in tool_conf_additions.xml to                #
# /galaxy-central/config/tool_conf.xml                                   #
##########################################################################


pip install blist

##########################################################################
#  Tools to upgrade python2 to python3                                   #
##########################################################################
pip install 2to3
pip install --upgrade autopep8


##########################################################################
#  GraphLan                                                              #
##########################################################################

##########################################################################
#  Important graphlan installation note <<<<------
#  Please the instructions located in galaxy-upgrade/Readme_Graphlan_Galaxy
#  The most important is to make sure that pyphlan is in galaxy/lib <<<--
#  We will copy pyphlan to /export/galaxy-central/lib  and also to 
#  /galaxy-central/lib
########################################################################## 

git clone https://github.com/SegataLab/graphlan.git
cd graphlan
pip install .
#pyphlan needed for helper scripts to modify input files 
cp /build/lib/src/pyphlan.py /galaxy_venv/bin/
chmod +x /galaxy_venv/bin/pyphlan.py
chown galaxy: /home/galaxy/.cache/matplotlib
chown galaxy: /home/galaxy/.config/matplotlib
graphlan.py 

cp -r /galaxy-central/tools/galaxy_graphlan/pyphlan  /export/galaxy-central/lib
cp -r /galaxy-central/tools/galaxy_graphlan/pyphlan  /export/galaxy-central/lib/galaxy
chown -R galaxy /export/galaxy-central/lib/pyphlan
chgrp -R galaxy /export/galaxy-central/lib/pyphlan
chown -R galaxy /export/galaxy-central/lib/galaxy/pyphlan
chgrp -R galaxy /export/galaxy-central/lib/galaxy/pyphlan



cp -r /galaxy-central/tools/galaxy_graphlan/pyphlan   /galaxy-central/lib
cp -r /galaxy-central/tools/galaxy_graphlan/pyphlan  /galaxy-central/lib/galaxy
chown -R galaxy  /galaxy-central/lib/pyphlan
chgrp -R galaxy  /galaxy-central/lib/pyphlan
chown -R galaxy /galaxy-central/lib/galaxy/pyphlan
chgrp -R galaxy  /galaxy-central/lib/galaxy/pyphlan

###################################################################
#   Modify ownership of tools directories
###################################################################
chown -R galaxy /galaxy-central/tools/panphlan
chgrp -R galaxy /galaxy-central/tools/panphlan

chown -R galaxy /galaxy-central/tools/metaphlan
chgrp -R galaxy /galaxy-central/tools/metaphlan

chown -R galaxy /galaxy-central/tools/sparsedossa
chgrp -R galaxy /galaxy-central/tools/sparsedossa

chown -R galaxy /galaxy-central/tools/maaslin
chgrp -R galaxy /galaxy-central/tools/maaslin

chown -R galaxy /galaxy-central/tools/galaxy_graphlan
chgrp -R galaxy /galaxy-central/tools/galaxy_graphlan

chown -R galaxy /galaxy-central/tools/graphlan
chgrp -R galaxy /galaxy-central/tools/graphlan
  
chgrp -R galaxy /galaxy-central/tools/waafle
chown -R galaxy /galaxy-central/tools/waafle
########################################################################
# Installation of Lefse       
########################################################################
git clone https://github.com/SegataLab/lefse.git
cd lefse
python3 setup.py install


########################################################################
#   MMUPHin
#######################################################################
R -q -e "install.packages('https://cran.r-project.org/src/contrib/Archive/locfit/locfit_1.5-9.4.tar.gz', repos=NULL, type='source')"
R -q -e "BiocManager::install('MMUPHin')"
R -q -e "BiocManager::install('curatedMetagenomicData')"
#######################################################################
#   Waafle
#######################################################################
pip install waafle
cd /galaxy-central/tools/galaxy_waafle/
wget http://huttenhower.sph.harvard.edu/waafle_data/waafledb.tar.gz -O /galaxy-central/tools/waafle/waafledb.tar.gz
wget http://huttenhower.sph.harvard.edu/waafle_data/waafledb_taxonomy.tsv -O /galaxy-central/tools/galaxy_waafle/waafledb_taxonomy.tsv 

git clone https://github.com/biobakery/waafle.git /galaxy-central/tools/  

###################################################################
#  Important waafle note :                                        #
###################################################################
# Please make sure that the waafle database files are located     *
# in the following directory:
#  /galaxy-central/tools/galaxy_waafle/waafledb such that it looks  
#  as follows:
#
#(galaxy_venv) root@e260ba359898:/galaxy-central/tools/galaxy_waafle/waafledb# pwd
# /galaxy-central/tools/galaxy_waafle/waafledb
# (galaxy_venv) root@e260ba359898:/galaxy-central/tools/galaxy_waafle/waafledb# ll
# total 7400072
# -rw-r--r-- 1 root 402050 662596427 Mar 18 23:47 waafledb.00.nhr
# -rw-r--r-- 1 root 402050  50813876 Mar 18 23:47 waafledb.00.nin
#-rw-r--r-- 1 root 402050 999999847 Mar 18 23:47 waafledb.00.nsq
# -rw-r--r-- 1 root 402050 659301143 Mar 18 23:47 waafledb.01.nhr
# -rw-r--r-- 1 root 402050  50935088 Mar 18 23:47 waafledb.01.nin
# -rw-r--r-- 1 root 402050 999999864 Mar 18 23:47 waafledb.01.nsq
# -rw-r--r-- 1 root 402050 645680680 Mar 18 23:47 waafledb.02.nhr
# -rw-r--r-- 1 root 402050  49674512 Mar 18 23:47 waafledb.02.nin
# -rw-r--r-- 1 root 402050 999999934 Mar 18 23:47 waafledb.02.nsq
# -rw-r--r-- 1 root 402050 653495133 Mar 18 23:47 waafledb.03.nhr
# -rw-r--r-- 1 root 402050  50326232 Mar 18 23:47 waafledb.03.nin
# -rw-r--r-- 1 root 402050 999999983 Mar 18 23:47 waafledb.03.nsq
# -rw-r--r-- 1 root 402050 285147206 Mar 18 23:47 waafledb.04.nhr
# -rw-r--r-- 1 root 402050  21815876 Mar 18 23:47 waafledb.04.nin
# -rw-r--r-- 1 root 402050 447856002 Mar 18 23:47 waafledb.04.nsq
# -rw-r--r-- 1 root 402050       142 Mar 18 23:47 waafledb.nal
# (galaxy_venv) root@e260ba359898:/galaxy-central/tools/galaxy_waafle/waafledb#
###################################################################
#  End of  waafle note                                            #
###################################################################


###################################################################
#   Modify ownership of tools directories
###################################################################
chown -R galaxy /galaxy-central/tools/panphlan
chgrp -R galaxy /galaxy-central/tools/panphlan

chown -R galaxy /galaxy-central/tools/metaphlan
chgrp -R galaxy /galaxy-central/tools/metaphlan
  
chown -R galaxy /galaxy-central/tools/sparsedossa
chgrp -R galaxy /galaxy-central/tools/sparsedossa

chown -R galaxy /galaxy-central/tools/maaslin
chgrp -R galaxy /galaxy-central/tools/maaslin

chown -R galaxy /galaxy-central/tools/galaxy_graphlan
chgrp -R galaxy /galaxy-central/tools/galaxy_graphlan

chown -R galaxy /galaxy-central/tools/graphlan
chgrp -R galaxy /galaxy-central/tools/graphlan

chgrp -R galaxy /galaxy-central/tools/waafle
chown -R galaxy /galaxy-central/tools/waafle

#Halla install
git clone https://github.com/biobakery/halla.git /galaxy-central/tools/galaxy_halla/halla
cd halla
python3.8 setup.py develop
chgrp -R galaxy /galaxy-central/tools/galaxy_halla
chown -R galaxy /galaxy-central/tools/galaxy_halla

chgrp -R galaxy /galaxy-central/tools/mmuphin
chown -R galaxy /galaxy-central/tools/mmuphin

### Install Picrust2 dependencies
#Install epa-ng
git clone https://github.com/Pbdas/epa-ng.git
make
cp /galaxy-central/tools/galaxy-upgrade/epa-ng/bin/epa-ng /bin/
#Install gappa
git clone --recursive https://github.com/lczech/gappa.git
cd gappa
make
cp /galaxy-central/tools/galaxy-upgrade/gappa/bin/gappa /bin/
#Install castor (R package)  
install.packages('castor')

