<vcf-filter.mk

VCF-FILTER_TARGETS= `{find -L data/ -name '*.vcf.gz' -o -name '*.vcf' \
		| sed -e 's#^data/#results/vcf-filter/#g' \
			-e 's#\.vcf(\.gz)?$#.filtered.vcf#g'}

vcf-filter:V:	$VCF-FILTER_TARGETS

results/vcf-filter/%.filtered.vcf:	data/%.vcf.gz	data/%.vcf.gz.tbi
	mkdir -p `dirname $target`
	zcat 'data/'$stem'.vcf.gz' \
	 | awk '/^#/ {print $0}; !/^#/ {exit}' \
	 > $target'.building'
	tabix 'data/'$stem'.vcf.gz' \
	 	-R $BED \
	>> $target'.building'
	mv $target'.building'	$target


