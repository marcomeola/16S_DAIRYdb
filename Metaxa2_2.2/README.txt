Metaxa2: Improved Identification and Classification of SSU sequences in Environmental Datasets

Source code available at:
http://microbiology.se/software/metaxa2

Version: 2.2 beta
Metaxa2 -- Identifies Small Subunit (SSU) rRNAs and classifies them taxonomically
Copyright (C) 2011-2016 Johan Bengtsson-Palme et al.
Contact: Johan Bengtsson-Palme, johan.bengtsson[at]microbiology.se
Programmer: Johan Bengtsson-Palme

A quick installation guide follows below.

Metaxa2 requires Perl, HMMER3, BLAST and MAFFT to function properly.

1) Perl is usually installed on Unix-like systems by default. If not, it can be retrieved from http://www.perl.org/

2) HMMER3 can be found at http://hmmer.janelia.org/software
Download it and follow the on site instructions for installation.

3) BLAST can be downloaded from ftp://ftp.ncbi.nlm.nih.gov/blast/executables/release/LATEST/
Both legacy BLAST and BLAST+ should work fine with Metaxa2.
Download the version for your platform and follow its installation instructions.

4) MAFFT can be obtained from http://mafft.cbrc.jp/alignment/software/
Download the package for your operating system, and follow the installation instructions on the download page. If you do not have admin privileges on your machine, take a look at these instructions: http://mafft.cbrc.jp/alignment/software/installation_without_root.html

5) Obtain the Metaxa2 package from http://microbiology.se/software/metaxa2
Unpack the tarball and move into the directory created from the tar-process.

6) Install Metaxa2 by running the script ./install_metaxa2 (or alternatively by copying all the files and the directory beginning with "metaxa2" into your preferred bin directory)

7) To test if Metaxa2 was successfully installed type "metaxa2 --help" on the command-line. You should now see the Metaxa2 help message.


To run Metaxa2, you need a FASTA-formatted output file. To check for SSU rRNA sequences in a FASTA file, type "metaxa2 -i file.fasta -o test" on the command line. If you are on a multicore machine, you might want to use the "--cpu 2" option to speed up the processes by using two (or more) cores.

If you encounter a bug or some other strange behaviour, please report it to:
metaxa[at]microbiology.se

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program, in a file called 'license.txt'. If not, see: http://www.gnu.org/licenses/.
