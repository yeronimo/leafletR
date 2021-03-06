toGeoJSON <-
function(data, name, dest, lat.lon, overwrite=TRUE) {
	if(missing(data)) stop("'data' is mandatory")
	if(missing(dest)) dest <- getwd()
	dest <- gsub("\\\\", "/", dest)
	if(substr(dest, nchar(dest), nchar(dest))=="/") dest <- substr(dest, 1, nchar(dest)-1)
	path <- NULL
	
	if(is.data.frame(data)) {
		if(missing(name)) name <- deparse(substitute(data))
		name <- gsub(" ", "_", name)
		if(missing(lat.lon)) lat.lon <- c(1,2)
		path <- dfToGeoJSON(data, name, dest, lat.lon, overwrite)
	} else if(class(data)=="character") {
		if(missing(name)) name <- strsplit(tail(strsplit(data, "/")[[1]], 1), "[.]")[[1]][1]
		name <- gsub(" ", "_", name)
		path <- fileToGeoJSON(data, name, dest, overwrite)
	} else if(class(data)[1]=="SpatialPoints" || class(data)[1]=="SpatialPointsDataFrame" || class(data)[1]=="SpatialLines" || class(data)[1]=="SpatialLinesDataFrame" || class(data)[1]=="SpatialPolygons" || class(data)[1]=="SpatialPolygonsDataFrame") {
		if(missing(name)) name <- deparse(substitute(data))
		name <- gsub(" ", "_", name)
		path <- spToGeoJSON(data, class(data)[1], name, dest, overwrite)
	} else {
		stop("Type of data not supported")
	}
	
	if(!is.null(path)) {
		message("\nFile saved under ", path)
		invisible(path)
	}
}
