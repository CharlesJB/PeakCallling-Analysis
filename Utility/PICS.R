argv <- commandArgs(trailingOnly = T)

if (length(argv) == 2) {
	library("PICS")
	library("Rsamtools")

	# Parse the arguments
	treatment <- argv[1]
	prefix <- argv[2]

	# Load the file
	print(paste("Loading treatment data: ", treatment, "...", sep=""))
	dataIP <- bam2gr(bamfile-treatment)

	# Do the actual analysis
	print("Starting segmentation of the data...")
	seg<-segmentPICS(dataIP, minReads=1)
	print("Doing the actual PICS analysis...")
	pics <- PICS(seg)

	# Save the results
	print("Saving results")
	myFilter<-list(score=c(2,Inf),delta=c(50,300),se=c(0,50),sigmaSqF=c(0,22500),sigmaSqR=c(0,22500))
	rdBed<-makeRangedDataOutput(pics,type="bed",filter=c(myFilter,list(score=c(1,Inf))))
	bed <- paste(prefix, "_peaks.bed", sep="")
	export(rdbed, bedName)

} else {
	writeLines("Usage: ")
	writeLines("")
	writeLines("Rscript PICS.R <treatment> <prefix>")
	writeLines("	treatment: treatment file in bam format")
	writeLines("	prefix: prefix for the output file")
	writeLines("")
}
