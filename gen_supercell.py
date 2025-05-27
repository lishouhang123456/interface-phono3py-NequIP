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
super_structure = dyn.structure.generate_supercell(supercell)
# %%
print("\nSupercell structure information:")
print("Number of atoms in supercell:", len(super_structure.atoms))
print("Supercell lattice vectors:\n", super_structure.unit_cell)
print("Atomic positions in supercell:")
for i, atom in enumerate(super_structure.atoms):
    print(f"Atom {i+1}: {atom}")
pos = super_structure.coords # in unit of angstrom
np.savetxt('super_pos',pos,fmt='%.16f',delimiter=' ')
# C = super_structure.cell
# Symbol = super_structure.symbols
# pos = super_structure.positions