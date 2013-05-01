argv <- commandArgs(trailingOnly = T)

if (length(argv) == 3) {
	library("PICS")
	library("Rsamtools")

	# Parse the arguments
	treatment <- argv[1]
	control <- argv[2]
	prefix <- argv[3]

	# Load the files
	print(paste("Loading treatment data: ", treatment, "...", sep=""))
	dataIP <- bam2gr(treatment)
	print(paste("Loading control data: ", control, "...", sep=""))
	dataCont <- bam2gr(control)

	# Do the actual analysis
	print("Starting segmentation of the data...")
	seg<-segmentPICS(dataIP, dataC=dataCont, minReads=1)
	print("Doing the actual PICS analysis...")
	pics <- PICS(seg, nCores=12)

	# Save the results
	library(rtracklayer)
	print("Saving results")
	myFilter<-list(score=c(2,Inf),delta=c(50,300),se=c(0,50),sigmaSqF=c(0,22500),sigmaSqR=c(0,22500))
	rdBed<-makeRangedDataOutput(pics,type="bed",filter=c(myFilter,list(score=c(1,Inf))))
	bedName <- paste(prefix, "_peaks.bed", sep="")
	export(rdBed, bedName)

} else {
	writeLines("Usage: ")
	writeLines("")
	writeLines("Rscript PICS_ctrl.R <treatment> <control> <prefix>")
	writeLines("	treatment: treatment file in bam format")
	writeLines("	control: control file in bam format")
	writeLines("	prefix: prefix for the output file")
	writeLines("")
}
