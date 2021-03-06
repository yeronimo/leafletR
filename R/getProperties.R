getProperties <-
function(data, print=TRUE) {
	stopifnot(require(RJSONIO, quietly=TRUE))
	
	# check if file exists and validate GeoJSON
	if(!file.exists(data)) stop("Data file not found")	
	if(!isValidJSON(data)) stop("Invalid GeoJSON")
	
	# get properties
	json <- fromJSON(data)
	prop <- NULL
	for(n in 1:length(json$features)) prop <- append(prop, names(json$features[[n]]$properties))
	prop <- unique(prop)
	
	if(print) print(prop)
	invisible(prop)
}
