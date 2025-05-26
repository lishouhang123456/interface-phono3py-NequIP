# %%
# Import the modules to read the dynamical matrix
import cellconstructor as CC
import cellconstructor.ForceTensor
import cellconstructor.Phonons

# Import the SSCHA modules
import cellconstructor.Units
import sscha
import sscha.Ensemble
import numpy as np
from phonopy.structure.atoms import PhonopyAtoms
from phonopy import Phonopy
import phono3py
import h5py
# Here the input/output information
DYN_PREFIX = "./final_dyn"
NQIRR = 8

print("===============RUNNING===================")
print()

print("Loading the original dynamical matrix...")
dyn = cellconstructor.Phonons.Phonons(DYN_PREFIX,NQIRR)
supercell= dyn.GetSupercell()

unitcell = PhonopyAtoms(symbols=dyn.structure.atoms, cell=dyn.structure.unit_cell, positions=dyn.structure.coords)
C = unitcell.cell
Symbol = unitcell.symbols
pos = unitcell.positions

np.savetxt('cell',C,fmt='%.16f',delimiter=' ')
np.savetxt('pos',pos,fmt='%.16f',delimiter=' ')
