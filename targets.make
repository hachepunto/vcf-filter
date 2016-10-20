find -L data/ \
	-name '*.vcf.gz' \
	-o -name '*.vcf' \
| sed \
	-e 's#^data/#results/vcf-filter/#g' \
	-e 's#\.vcf(\.gz)?$#'$BED'.filtered.vcf#g'