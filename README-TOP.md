# Extracting mentions of publications in WoC


Quite a bit of research has been conducted on identifying software
cited or mentioned in research publications.  Since software projects
are not required to cite related research, most software projects in
OSS don't mention any research publication. We investigated the
practice of citing research publications in OSS by using World of Code
infrastructure to identify all instances where a research publication
was mentioned in all version of all files matching a certain filename
pattern. Among the objectives we had was to identify a reference to a
paper that is mentioned in the largest number of software
projects. The intent was to capture one aspect of the paper's
influence on software projects.

Two radically different papers topped our list. The first paper
"Levine J. Coordinated Universal Time and the leap second. URSI Radio Sci Bull. 2016;89(4):30-6.
doi:10.23919/URSIRSB.2016.7909995" was in 55,034 distinct repositories, but only three versions
of the file citing it exist. In this case the reference was widely spread because it was in
a python package pytz that was widely installed (and checked in).

The second paper: "Orchestrating high-throughput genomic analysis with
Bioconductor" doi://10.1038/nmeth.3252 was mentioned in 27774 projects
with 55806 distinct versions. In this case, the paper was describing
bioconductor package manager (an alternative to the standard CRAN
package manager used for R language).
The total number of repositories once deforked was only 43 as one repository
was forked overe 24K times.


The first paper had only one paper in semanticscolar that cited it,
while the second had thousands of citations.
These findings suggest that it the impact a paper has on software may require carefully designed multi-dimensional
measures that quantify differet types of impact.       


#### Details

We looked for keywords zenodo|doi|article|proceedings|journal|conference in the content of all version of
files that contained readme|citation|bibliography in their pathname.

Projects were deforked to avoid counting the same file in multiple forks.


### Top papers
```
# find most widely spread doi
```
zcat doi2P| cut -d\; -f1 | uniq -c | sort -rn |head
  54862 10.23919/URSIRSB.2016.7909995
  12787 10.1145/2827872
   6311 10.1007/s13748-013-0040-3
   3070 /
   2889 10.1016/j.dss.2009.05.016
   1872 10.17487/RFC7518
   1872 10.17487/RFC7516
   1872 10.17487/RFC7515
   1598 10.7717/peerj-cs.214
   1511 10.17487/RFC7519
```
# What are these projects
Very wide variety, better look at files involved
```
echo 3b9cc7b20317766a22c02a151c9ec0e79692a3d4| ~/lookup/getValues -f b2f| cut -d\; -f2- | head
$RECYCLE.BIN/S-1-5-21-1015804952-638651903-1369472992-1001/$RJKSRU8/env/Lib/site-packages/pytz/zoneinfo/leapseconds
%HOMEPATH%/.virtualenvs/djangodev/Lib/site-packages/pytz/zoneinfo/leapseconds
(Post-July) 4. Django/django_env/Lib/site-packages/pytz/zoneinfo/leapseconds
.ENV/lib/python3.7/site-packages/pytz/zoneinfo/leapseconds
.TicketSystemVenv/Lib/site-packages/pytz/zoneinfo/leapseconds
.aws-sam/build/Lambda1/pytz/zoneinfo/leapseconds
.aws-sam/build/Lambda2/pytz/zoneinfo/leapseconds
.aws-sam/build/StreamripperSchedulerFunction/pytz/zoneinfo/leapseconds
.bookenv/lib/python3.7/site-packages/pytz/zoneinfo/leapseconds
.bot/lib/python3.8/site-packages/pytz/zoneinfo/leapseconds
```
# doi with most blobs
```
zcat doi2b.s|cut -d\; -f1 |uniq -c | lsort 1G -rn |head
  55806 10.1038/nmeth.3252
  11590 10.1051/0004-6361
  10323 10.1023/A
  10172 10.1088/0004-637x/705/1/1000
  10141 10.1126/science.aac6933
  10106 10.1086/169376
  10103 10.1038/nature16171
  10088 10.1146/annurev-astro-082708-101737
  10086 10.1103/revmodphys.74.1015
  10086 10.1088/0004-637x/690/2/1715
```
# how many blobs the first (seconds) paper has (only three)?
```
zcat doi2b.s|cut -d\; -f1 |uniq -c |grep 10.23919/URSIRSB.2016.7909995
     3 10.23919/URSIRSB.2016.7909995
```
# how many projects the second (bio) paper has (only 42)?
```
zcat doi2P| cut -d\; -f1 | uniq -c | grep 10.1038/nmeth.3252
     42 10.1038/nmeth.3252
```
# What are these projects?
```
cat doi2P | grep  10.1038/nmeth.3252 | cut -d\; -f2
Cran_liftr
MalteThodberg_CAGEWorkflow
Tanguay-Lab_Manuscripts
acgtcoder_csama2016
acidgenomics_pfgsea
acidgenomics_r-acidmarkdown
amdehaan_abds_2019
binyam46_csama
bioconda_bioconda.github.io
dave-s477_SoMeSci
dieterich-lab_Baltica
fgcz_MsBackendRawFileReader
gcushen_hugo-academic
grst_bioqc_geo
hbc_MouseKidneyFibrOmics
hbc_albert_edge-niki_gunewardene-ear_hair_cells_rnaseq
hbc_bcbioRNASeq
hbc_breault_richmond_rnaseq_intestinal_fasting
hbc_david_christiani-sipeng_shen-lung_cancer_paired_rnaseq
hbc_kronenberg_balani_single_cell
hbc_marcos_vidal_melo-two_lung_LPS_regional
hbc_msteinhauser_starvation_timeseries
hbc_projects
hbc_sandra_mcallister_lung_distal_tumor
hbc_william_mair_caroline_heintz_splicing_celegans_rnaseq
jdieramon_Publications
lpeso_TFEA_paper
mdozmorov_BIOS691_Cancer_Bioinformatics
mikelove_rnaseqDTU
mikelove_rnaseqGene
mjsteinbaugh_eggan-dbGaP-phs000747.v2.p1
nanxstats_dockflow
naumenko-sa_eggan-es_derived_motor_neuron_knockdown-rnaseq-human
nturaga_workflows
road2stat_liftr
sa-lee_thesis
seandavi_BiocExptDataPkgManuscript
seqcloud_common
tamirna_miND
theislab_scanpy
timflutre_VitisOmics
xiaoyaoziyao_msc_project
```
# Why so many blogs if so few projects? (many forks)
```
cat doi2P | grep  10.1038/nmeth.3252 | cut -d\; -f2 | ~/lookup/getValues -f P2p > bio.P2p 
wc bio.P2p 
  27774   27774 1385869 bio.P2p
```
# do some of the repos have most forks? (yes gcushen_hugo-academic)
```
cut -d\; -f1 bio.P2p | uniq -c
      3 Cran_liftr
      2 MalteThodberg_CAGEWorkflow
      1 Tanguay-Lab_Manuscripts
      3 acgtcoder_csama2016
      4 acidgenomics_pfgsea
      1 acidgenomics_r-acidmarkdown
      2 amdehaan_abds_2019
     21 binyam46_csama
     20 bioconda_bioconda.github.io
      1 dave-s477_SoMeSci
      1 dieterich-lab_Baltica
      3 fgcz_MsBackendRawFileReader
  27311 gcushen_hugo-academic
      1 grst_bioqc_geo
      1 hbc_MouseKidneyFibrOmics
      1 hbc_albert_edge-niki_gunewardene-ear_hair_cells_rnaseq
     25 hbc_bcbioRNASeq
      1 hbc_breault_richmond_rnaseq_intestinal_fasting
      1 hbc_david_christiani-sipeng_shen-lung_cancer_paired_rnaseq
      1 hbc_kronenberg_balani_single_cell
      1 hbc_marcos_vidal_melo-two_lung_LPS_regional
      1 hbc_msteinhauser_starvation_timeseries
     13 hbc_projects
      1 hbc_sandra_mcallister_lung_distal_tumor
      1 hbc_william_mair_caroline_heintz_splicing_celegans_rnaseq
      2 jdieramon_Publications
      1 lpeso_TFEA_paper
      2 mdozmorov_BIOS691_Cancer_Bioinformatics
     10 mikelove_rnaseqDTU
     21 mikelove_rnaseqGene
      1 mjsteinbaugh_eggan-dbGaP-phs000747.v2.p1
      2 nanxstats_dockflow
      2 naumenko-sa_eggan-es_derived_motor_neuron_knockdown-rnaseq-human
      1 nturaga_workflows
     23 road2stat_liftr
      1 sa-lee_thesis
      1 seandavi_BiocExptDataPkgManuscript
      9 seqcloud_common
      1 tamirna_miND
    271 theislab_scanpy
      4 timflutre_VitisOmics
      1 xiaoyaoziyao_msc_project

```

# What are these papers?
```
3b9cc7b20317766a22c02a151c9ec0e79692a3d4
# The International Earth Rotation and Reference Systems Service (IERS)
# periodically uses leap seconds to keep UTC to within 0.9 s of UT1
# (a proxy for Earth's angle in space as measured by astronomers)
# and publishes leap second data in a copyrighted file
# <https://hpiers.obspm.fr/iers/bul/bulc/Leap_Second.dat>.
# See: Levine J. Coordinated Universal Time and the leap second.
# URSI Radio Sci Bull. 2016;89(4):30-6. doi:10.23919/URSIRSB.2016.7909995
zcat fatcat_bulk_exports_2024-02-18/release_export_expanded.json.gz | grep --color=auto -i 'Coordinated Universal Time and the leap secon' > seconds
```


```
10.1038/nmeth.3252;6112893;    Perspective Published: 29 January 2015; Orchestrating high-throughput genomic analysis with Bioconductor
{"corpusid":209884733,"externalids":{"ACL":null,"DBLP":null,"ArXiv":null,"MAG":"2795565782","CorpusId":"209884733","PubMed":null,"DOI":null,"PubMedCentral":null},"url":"https://www.semanticscholar.org/paper/980af8340bf44d3e5621addc82c6cac0e6d508ca","title":"Coordinated Universal Time and the Leap Second | NIST","authors":[{"authorId":"143842258","name":"J. Levine"}],"venue":"","p
ublicationvenueid":null,"year":2016,"referencecount":0,"citationcount":1,"influentialcitationcount":1,"isopenaccess":false,"s2fieldsofstudy":[{"category":"Physics","source":"s2-fos-model"},{"category":"Physics","source":"external"}],"publicationtypes":null,"publicationdate":"2016-12-01","journal":{"name":"Radio Science","pages":null,"volume":""}}

#these are semanticscolar ids for the two papers
zcat sematicscolar/papers-part*.jsonl.gz | grep --color=auto -i 'Coordinated Universal Time and the leap sec' > seconds1
cat top 
:6112893,
:209884733,
```

# how widely each is cited by other papers?
```
zcat sematicscolar/citations-part*.jsonl.gz | grep --color=auto -Ff top > top.citations
#biocond paper
grep -w ':6112893,' top.citations  | wc
   2852   54673  768806
#seconds paper
grep -w ':209884733,' top.citations      
{"citationid":4740408346,"citingcorpusid":268754447,"citedcorpusid":209884733,"isinfluential":true,"contexts":["To ensure agreement between UTC an
d the time derived from the Earth's rotation (UT1), TAI is compared with UT1, if the difference is greater than 0.9 seconds, a Leap Second is appl
ied (Levine, 2016)."],"intents":[["methodology"]]}
```

# Why are these so widely spread




