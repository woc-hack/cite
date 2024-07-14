i=$1
zcat b2f$i.dat| grep -i doi: | perl -ane '($b,$f,@S)=split(/;/);$s=join " ", @S;$r="";while($s=~m|\b([dD][oO][iI]:[ \[\]/0-9\.a-zA-Z]*)|g){$r.="|$1"};print "$b;$f;$r\n" if $r ne "";' | gzip > b2f$i.doi 
zcat b2f$i.dat| grep -i 'doi\.org/' | perl -ane '($b,$f,@S)=split(/;/);$s=join " ", @S;$r="";while($s=~m|\b([dD][oO][iI]\.[oO][Rr][gG]/[/0-9\.a-zA-Z]*)|g){$r.="|$1"};print "$b;$f;$r\n" if $r ne "";' | gzip > b2f$i.doi1 
zcat /da5_data/play/cite/b2f$i.dat| grep -Ei '\@(article|inproceedings|book)' | cut -d\; -f1 | uniq > /da5_data/play/cite/b2f$i.bib
zcat /da5_data/play/cite/b2f$i.dat| grep -i 'zenodo' | cut -d\; -f1 | uniq > /da5_data/play/cite/b2f$i.zenodo
zcat /da5_data/play/cite/b2f$i.dat| grep -i 'arxiv' | cut -d\; -f1 | uniq > /da5_data/play/cite/b2f$i.axiv
zcat /da5_data/play/cite/b2f$i.doi{,1} |cut -d\; -f1 | uniq | sort -u > /da5_data/play/cite/b2f$i.doi.c
zcat /da5_data/play/cite/b2f$i.dat| cut -d\; -f1 | uniq | sort -u > /da5_data/play/cite/b2f$i.doi.a
join -v1 /da5_data/play/cite/b2f$i.{bib,doi.c} | join -t\; - <(zcat /da7_data/basemaps/gz/b2P128FullV.$i.gz) | gzip > /da5_data/play/cite/b2f$i.bibP
join -t\; /da5_data/play/cite/b2f$i.doi.c <(zcat /da7_data/basemaps/gz/b2P128FullV.$i.gz) | gzip > /da5_data/play/cite/b2f$i.doiP
zcat /da5_data/play/cite/b2f$i.doiP | join -t\; - <(zcat /da5_data/play/cite/b2f$i.doi) | cut -d\; -f2,4| perl -ane 'chop();($p,$s)=split(/;/);$s=~s/^|//;@S=split(/\|/,$s); for my $s (@S){ print "$p;$s\n" if $s !~ /^\s*$/}'  |lsort 10G -u | cut -d\; -f1 |uniq -c > /da5_data/play/cite/b2f$i.nCperP
###extract cite info from /da5_data/play/cite/b2f$i.bibP
zcat /da5_data/play/cite/b2f$i.bibP  | perl /da5_data/play/cite/getBib.perl | gzip > /da5_data/play/cite/b2f$i.bib.full
zcat /da5_data/play/cite/b2f$i.bib.full | uniq | cut -d\; -f2,4 | uniq | cut -d\; -f1 | uniq -c > b2f$i.bib.nCperP
#zcat /da5_data/play/cite/b2f$i.bibP | cut -d\; -f2 | sort | uniq -c | sort -n

#(for i in {0..31}; do zcat /da1_data/basemaps/gz/P2summFullV$i.json; done |  perl -ane '$l=$_;$l=~m|"ProjectID":"([^"]*)|; $p=$1; $na=0;if($l=~m|"NumAuthors":([0-9]*)|){$na=$1;};$nc=0;if($l=~m|"NumCommits":([0-9]*)|){$nc=$1};print "$p;$na;$nc\n"') | lsort 50G | gzip > /da5_data/play/cite/P2nAc
#for i in {0..31}; do zcat /da5_data/play/cite/b2f$i | ~/lookup/showCnt1 blob | grep --color=auto -iE 'zenodo|doi|article|proceedings|journal|conference' | gzip > /da5_data/play/cite/b2f$i.dat; done

#for i in {0..127}; do zcat /da7_data/basemaps/gz/b2fFullV$i.s | grep -Ei 'readme|citation|bibliography' | gzip > /da5_data/play/cite/b2f$i; done
#/da5_data/play/cite/doi.sh $i > /dev/null
#cat /da5_data/play/cite/b2f[0-3].*nCperP | awk '{print $2";"$1}' | lsort 1G -t\; -k1,1 | join -t\; - <(zcat /da5_data/play/cite/P2nAc |lsort 10G -t\; -k1,1) > /da5_data/play/cite/b2fStat0-3

#redo
#zcat b2f$i.dat| grep -i 'doi[:\. ]' | perl -ane '($b,$f,@S)=split(/;/);$s=join " ", @S;$r="";while($s=~m|\b([dD][oO][iI]:.*)|g){$r.="|$1"};print "$b;$f;$r\n" if $r ne "";' | gzip > b2f$i.doi


