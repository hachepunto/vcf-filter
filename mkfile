<vcf-filter.mk

VCF_FILTER_TARGETS= `{./targets}

vcf-filter:VE:	$VCF_FILTER_TARGETS

'results/vcf-filter/(.*)_filtered_by_(.*).vcf.gz':RD:	'data/\1.vcf.gz'	'data/\1.vcf.gz.tbi'	$BED_DIRECTORY'/\2'
	mkdir -p `dirname $target`
	BED_FILE="$BED_DIRECTORY/$stem2"
	zcat 'data/'$stem1'.vcf.gz' \
	| awk '/^#/ {print $0}; !/^#/ {exit}' \
	> $target'.building'
	tabix 'data/'$stem1'.vcf.gz' \
		-R "$BED_FILE" \
	>> $target'.building'
	mv $target'.building'	$target

clean:V:
	rm -r results

clean_failed:V:
	find result -name '*.building' -delete
