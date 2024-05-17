# script generado usando la guia del video https://www.youtube.com/watch?v=_3vJSBk0Bls

import Pkg
Pkg.activate()
Pkg.add("PackageCompiler")

using PackageCompiler

filetype = "so"

common_packages = [ 
    "DaemonMode", 
    "Distributed", 
    "DataFrames",
    "CSV",  
#    "ExcelFiles", 
#    "XLSX", 
#    "Statistics", 
    "DataStructures",
# Por algun bug en el modulo produce que se quede el proceso de manera indeterminada creando la imagen
#    "Plots", 
    "Memento", 
    "InfrastructureModels", 
    "Ipopt", 
    "PowerModels", 
    "JuMP", 
    "PowerModelsACDC", 
    "Combinatorics",
    "Random",
    "Waveforms",
    "Distributions",
    "SharedArrays", 
    "SparseArrays",
]

Pkg.add(common_packages)

create_sysimage(common_packages; sysimage_path="opf-sysimage.$filetype")
