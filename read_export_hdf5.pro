PRO read_export_hdf5
;The newest HyTES imagery (http://hytes.jpl.nasa.gov/) comes in an hdf5 format (https://www.hdfgroup.org/).
;This code reads in the hdf5 file, selects a layer of the file, and outputs
;that layer to an envi file for future processing.  
;For More Info: https://www.harrisgeospatial.com/docs/hdf5_overview.html 
;Susan Meerdink
;8/1/2016
;
;REQUIREMENTS:
;IDL 64 bit
;New (not classic) ENVI
;----------------------------------------------------------------------------------------------------------
;;; VARIABLES TO SET ;;;
directory = 'F:\Imagery\HyTES\2016_01_25 Huntington Gardens\' ; Directory that holds file and output file will be stored here
filename = '2016-01-25.223617.HuntingtonGardens.Line1-Run1-Segment01.L2.hdf5' ; HDF5 Filename
datasetname = 'l2_emissivity_smooth' ; Dataset name you want to extract
outname = '2016-01-25_Huntington_Gardens_SMemissivity' ; Output file name

; Other Dataset Names
; 'l2_PCemis' = PC Emissivity Product
; 'l2_emissivity' = TES Emissivity Product
; 'l2_emissivity_smooth' = Smoothed TES Emissivity Product
; 'l2_land_surface_temperature' = LST Product estimated from TES Product
;;; DONE SETTING VARIABLES ;;;

e = ENVI(HEADLESS = 1) ; Launch the application without opening the user interface
CD, directory ;changing directory

;;; ADDITIONAL VARIABLES FOR MEMORY PURPOSES ;;;
outImage = MAKE_ARRAY([800, 250, 10000], TYPE = 2, VALUE = 0) ;Create empty array that is large for memory allocation purposes
outImage = 0 ;Set to zero for memory purposes
;;; DONE ADDITIONAL VARIABLES FOR MEMORY PURPOSES ;;;

;;; LOADING IN DATA ;;;;
file = directory + filename ;Set to file path of hdf5 file to be opened
fileOut = directory + outname ;Set to output file name
file_id = H5F_OPEN(file) ;Open the HDF5 file
dataset = H5D_OPEN(file_id,'/' + datasetname); Open the image dataset within the file - TES Emissivity Product
raster = H5D_READ(dataset); Read in the actual image data
dims = size(raster,/DIMENSIONS);get dimensions of array (right now reporting as bands, samples, lines)
;print, dims
;;; DONE LOADING IN DATA ;;;;

;;; WRITE DATA TO ENVI FILE ;;;
ENVI_WRITE_ENVI_FILE, raster, $ ; Data to write to file
  OUT_NAME = fileOut, $ ;Output file name
  NB = dims[0], $; Number of Bands
  NL = dims[2], $ ;Number of lines
  NS = dims[1], $ ;Number of Samples
  INTERLEAVE = 2 , $ ;Set this keyword to one of the following integer values to specify the interleave output: 0: BSQ 1: BIL 2: BIP
  R_FID = fidTemp, $ ;Set keyword for new file's FID
  OFFSET = 0 ; Use this keyword to specify the offset (in bytes) to the start of the data in the file.
;;; DONE WRITING DATA TO ENVI FILE ;;;

print, 'Done'
END