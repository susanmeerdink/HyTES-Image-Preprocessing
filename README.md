# HyTES-Image-Preprocessing

Project containing code to pre-process HyTES imagery

## Code Descriptions
read_export_hdf5.pro: The 2016 HyTES imagery is distributed as HDF5 file. Only the new ENVI gui (NOT classic) 
is able to open and read the file. However, it was not possible to pull out a layer and save as separate envi file. This code reads in that layer (emissivity) and saves it as an envi file. 